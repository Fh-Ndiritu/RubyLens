class RenameSourceToJobSiteIdInJobs < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :source, :job_site_id
  end
end
