class ChangeMeasureColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :measures, :type, :measure_type
    rename_column :committees, :type, :committee_type
  end
end
