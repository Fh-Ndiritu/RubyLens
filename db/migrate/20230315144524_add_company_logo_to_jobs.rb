class AddCompanyLogoToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :company_logo, :string
  end
end
