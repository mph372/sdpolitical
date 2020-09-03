class AddPendingCancellationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :cancellation_pending, :boolean, default: false
  end
end
