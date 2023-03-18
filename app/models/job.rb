class Job < ApplicationRecord
    belongs_to :job_site

    delegate :name, to: :job_site
    delegate :url,  to: :job_site
    default_scope {where.not(title: nil).order('date_posted desc')}

    scope :last_month, ->{ where('date_posted > ?', 1.months.ago) }
end
