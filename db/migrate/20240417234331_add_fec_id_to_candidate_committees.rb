class AddFecIdToCandidateCommittees < ActiveRecord::Migration[6.1]
  def change
    add_column :candidate_committees, :fec_id, :string
  end
end
