class AddBallotTitlesToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :ballot_title, :string
  end
end
