class AddDataToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_reference :candidates, :candidate_committee, foreign_key: true
    add_column :candidates, :first_name, :string
    add_column :candidates, :last_name, :string
    add_column :candidates, :votes, :integer
    add_column :candidates, :endorsed_republican, :boolean
    add_column :candidates, :endorsed_democrat, :boolean
  end
end

