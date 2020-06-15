class ChangeSupportFormatInCommittees < ActiveRecord::Migration[5.2]
  def up
    change_column :committees, :support, :string
  end

  def down
    change_column :committees, :support, :boolean
  end
end
