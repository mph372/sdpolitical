class AddIncumbentToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :incumbent_report, :boolean
  end
end
