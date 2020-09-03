class AddFreeAccountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :free_account, :boolean, default: false 
  end
end
