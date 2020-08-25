class AddEmailNotificationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notify_when_new_expenditure, :boolean, default: true
  end
end
