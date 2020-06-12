class AddCandidateToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :candidate, foreign_key: true
  end
end
