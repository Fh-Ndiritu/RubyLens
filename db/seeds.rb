# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
job_sites = [
    {
        name: 'Go Rails',
        url: 'https://jobs.gorails.com/'
    },
    {
        name: 'Rails + Hotwire Jobs', 
        url: 'https://railshotwirejobs.com/'
    },
    {
        name: 'Ruby on Remote', 
        url: 'https://rubyonremote.com/'
    }
]

job_sites.each do |site|
    JobSite.create!(site)
end

