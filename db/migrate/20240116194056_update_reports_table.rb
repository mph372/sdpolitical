class UpdateReportsTable < ActiveRecord::Migration[6.1]
  def change
    change_table :reports do |t|
      # Remove columns
      t.remove :person_id, :cycle, :district_id, :incumbent_report, :candidate_report, :officeholder_account, :orig_e_filing_id, :e_filing_id

      # Add new columns
      t.float :period_monetary_receipts
      t.float :period_nonmonetary_receipts
    end
  end
end
