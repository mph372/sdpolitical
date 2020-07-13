class AddOfficeholderAccountToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :officeholder_account, :boolean, :default => false
  end
end
