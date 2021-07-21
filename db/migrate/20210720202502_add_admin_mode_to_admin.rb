class AddAdminModeToAdmin < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :admin_mode, :boolean, default: true
  end
end
