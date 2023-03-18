class CrawlerController < ApplicationController

  def go_and_hotwire(job_site)
    doc = Nokogiri::HTML(URI.open(job_site.url))

    # Search for nodes by css
    doc.css('ul.space-y-4 li').each do |link|
      pay = link.css('p')[5]&.content&.strip
      if !pay&.include?('$')
        days_ago = pay&.scan(/\d+/)&.first
        pay = nil
      else
        days_ago = link.css('p')[6]&.content&.scan(/\d+/)&.first
      end

      date = DateTime.now - days_ago.to_i.days
      next unless date > 30.days.ago
       
      Job.find_or_create_by(
        :title => link.css('h3')&.first&.content,
        :company => link.css('p')&.first&.content,
        :remote => link.css('p')[3]&.content&.strip&.include?("Remote") && "Remote" || nil,
        :location => link.css('p')[4]&.content&.strip,
        :salary => pay
        ) do |job|
          job.date_posted = date
          job.post_url    = link.css('a')&.first['href']
          job.job_type    = link.css('p')[2]&.content&.strip
          job.job_site_id = job_site.id
          job.company_logo = link.css('img').first['src'] if link.css('img')&.first

          post_url = link.css('a')&.first 
          if post_url
            job.post_url = post_url['href']

            full_post = Nokogiri::HTML(URI.open(job_site.url+job.post_url))
            job.description =  full_post.css('.rich-content')&.first&.inner_html

            apply_link = full_post.css('h1')&.first&.parent&.parent&.css('a')&.last
            job.apply_url =  apply_link['href'] if apply_link
          end

          job.save

      end

    end

  end

  def ruby_on_remote(job_site)
    doc = Nokogiri::HTML(URI.open(job_site.url+'#job-listings'))
    doc.css('li').each do |link|
      date = Time.parse(link.css('p')&.last&.content&.strip)
      next unless date > 30.days.ago 

      Job.find_or_create_by(
        :title => link.css('h2')&.first&.content&.strip,
        :company => link.css('p')&.first&.content&.strip,
        :remote => "Remote",
        :location => link.css('span')&.last&.content&.strip
        ) do |job|
          job.date_posted = date
          job.job_site_id = job_site.id
          job.company_logo = link.css('img').first['src'] if link.css('img')&.first

          post_url = link.css('a')&.first
          if post_url
            job.post_url = post_url['href']

            full_post = Nokogiri::HTML(URI.open(job_site.url+job.post_url))
            job.description =  full_post.css('.trix-content')&.first&.inner_html

            job.apply_url =  full_post.css('a#apply_link')&.first['href'] if full_post.css('a#apply_link')
            

            locations = ""
            full_post.css('.job-tags').each do |tag|
              tag_arr = tag['href']&.split('/')&.second&.split('-')
              next unless tag_arr
              locations += tag_arr.last + ", " if tag['href'].include?('-in-')

              job.job_type = tag['href'].gsub('-remote-jobs/', '').delete_prefix('/') if tag['href'].include?('time') or tag['href'].include?('contract')
            end
            job.location = locations.chomp(', ')
          end
          job.save

      end

    end

  end

  def dynamite(job_site)
    return
    doc = Nokogiri::HTML(URI.open(job_site.url))

  end



  def start
    JobSite.all.each do |job_site|

      if job_site.name == 'Ruby on Remote'
       ruby_on_remote(job_site)
      end
      go_and_hotwire(job_site)
    end
    redirect_to root_path

  end

end
