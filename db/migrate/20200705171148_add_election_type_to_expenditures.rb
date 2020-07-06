class AddElectionTypeToExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_column :expenditures, :election_type, :string
    add_column :expenditures, :election_cycle, :integer
  end
end
