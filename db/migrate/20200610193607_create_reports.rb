class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :incumbent, foreign_key: true
      t.date :period_begin
      t.date :period_end
      t.date :report_filed
      t.integer :period_receipts
      t.integer :period_disbursements
      t.integer :current_coh
      t.integer :current_debt
      t.timestamps
    end
  end
end
