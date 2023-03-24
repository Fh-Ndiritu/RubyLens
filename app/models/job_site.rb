class JobSite < ApplicationRecord
    has_many :jobs
    validates :name, uniqueness: true
end