class AddLoansToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :loans_received, :float
  end
end
