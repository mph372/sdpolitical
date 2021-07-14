class AddPrimaryToCandidateCommittee < ActiveRecord::Migration[5.2]
  def change
    add_column :candidate_committees, :primary_committee, :boolean
  end
end
