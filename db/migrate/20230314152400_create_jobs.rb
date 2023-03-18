class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :source
      t.string :company
      t.boolean :remote
      t.string :location
      t.string :salary
      t.datetime :date_posted
      t.string :type
      t.text :description
      t.string :apply_url

      t.timestamps
    end
  end
end
