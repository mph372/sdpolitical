class AddCandidateReportToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :candidate_report, :boolean
  end
end
