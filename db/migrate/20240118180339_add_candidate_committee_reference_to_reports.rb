class AddCandidateCommitteeReferenceToReports < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:reports, :candidate_committee_id)
      add_reference :reports, :candidate_committee, foreign_key: true
    end
  end
end
