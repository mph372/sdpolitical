class AddVoteForToContests < ActiveRecord::Migration[6.1]
  def change
    add_column :contests, :vote_for, :integer
    add_index :contests, :vote_for
  end
end