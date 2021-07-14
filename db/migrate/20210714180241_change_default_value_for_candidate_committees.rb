class ChangeDefaultValueForCandidateCommittees < ActiveRecord::Migration[5.2]
  def change
    change_column :candidate_committees, :primary_committee, :boolean, :default => false
  end
end
