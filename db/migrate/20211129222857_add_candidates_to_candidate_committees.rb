class AddCandidatesToCandidateCommittees < ActiveRecord::Migration[5.2]
  def change
    add_reference :candidate_committees, :candidate, foreign_key: true
  end
end
