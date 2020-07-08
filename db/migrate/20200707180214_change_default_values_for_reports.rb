class ChangeDefaultValuesForReports < ActiveRecord::Migration[5.2]
  def change
    change_column_default :reports, :candidate_report, true
  end
end
