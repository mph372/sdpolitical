class AddReelectionToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :running_reelection, :boolean
  end
end
