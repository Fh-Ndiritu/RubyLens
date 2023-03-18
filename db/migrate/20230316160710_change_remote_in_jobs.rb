class ChangeRemoteInJobs < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :remote, :string
  end
end
