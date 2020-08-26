class AddReportNotificationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notify_when_new_report, :boolean, default: true
  end
end
