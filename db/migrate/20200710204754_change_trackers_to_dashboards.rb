class ChangeTrackersToDashboards < ActiveRecord::Migration[5.2]
  def change
    rename_table :trackers, :dashboards
  end
end
