class AddCycleToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :cycle, :integer
  end
end
