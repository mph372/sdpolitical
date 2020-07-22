class ChangeDataTypesOnReports < ActiveRecord::Migration[5.2]
  def up
    change_column :reports, :period_receipts, :float
    change_column :reports, :period_disbursements, :float
    change_column :reports, :current_coh, :float
    change_column :reports, :current_debt, :float
    change_column :reports, :loans_received, :float
  end

  def down
    change_column :reports, :period_receipts, :integer
    change_column :reports, :period_disbursements, :integer
    change_column :reports, :current_coh, :integer
    change_column :reports, :current_debt, :integer
    change_column :reports, :loans_received, :integer
  end
end

