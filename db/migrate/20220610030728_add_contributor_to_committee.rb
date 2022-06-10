class AddContributorToCommittee < ActiveRecord::Migration[5.2]
  def change
    add_reference :contributors, :committee, foreign_key: true
  end
end
