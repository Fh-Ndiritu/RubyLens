class RenameTypeToJobTypeForJobs < ActiveRecord::Migration[6.1]
  def change
    rename_column :jobs, :type, :job_type
  end
end
