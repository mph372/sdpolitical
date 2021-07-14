class AddCommitteesToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :candidate_committee, foreign_key: true
  end
end
