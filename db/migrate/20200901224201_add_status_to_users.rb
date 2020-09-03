class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscription_display, :string
  end
end
