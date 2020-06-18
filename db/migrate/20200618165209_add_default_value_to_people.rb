class AddDefaultValueToPeople < ActiveRecord::Migration[5.2]
  def up
    change_column :people, :on_ballot, :boolean, default: false
    change_column :people, :running_reelection, :boolean, default: false
  end
  
  def down
    change_column :people, :on_ballot, :boolean, default: nil
    change_column :people, :running_reelection, :boolean, default: nil
  end
end
