class AddBallotsOutstandingToElectionUpdates < ActiveRecord::Migration[6.1]
  def change
    add_column :election_updates, :ballots_outstanding, :integer
  end
end
