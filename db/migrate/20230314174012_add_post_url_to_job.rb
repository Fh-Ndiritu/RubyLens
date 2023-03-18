class AddPostUrlToJob < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :post_url, :string
  end
end
