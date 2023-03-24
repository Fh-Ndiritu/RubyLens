class AboutController < ApplicationController
  def index
    @job_sites = JobSite.all.select(:url, :name)
  end
end
