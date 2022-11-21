class AddFilingIdToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :orig_e_filing_id, :integer
    add_column :reports, :e_filing_id, :integer
  end
end
