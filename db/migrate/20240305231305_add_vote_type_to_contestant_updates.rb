class AddVoteTypeToContestantUpdates < ActiveRecord::Migration[6.1]
  def change
    add_column :contestant_updates, :vote_type, :string
  end
end
