class CreateJobSite < ActiveRecord::Migration[6.1]
  def change
    create_table :job_sites do |t|
      t.string :name
      t.string :url
      t.string :logo

      t.timestamps
    end
  end
end
