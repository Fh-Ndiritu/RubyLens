json.extract! job, :id, :title, :source, :company, :remote, :location, :salary, :date_posted, :type, :description, :apply_url, :created_at, :updated_at
json.url job_url(job, format: :json)
