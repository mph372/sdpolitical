class AddDetailsToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :ballot_status, :string
  end
end
