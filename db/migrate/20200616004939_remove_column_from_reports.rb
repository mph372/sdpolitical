class RemoveColumnFromReports < ActiveRecord::Migration[5.2]
  def change
    remove_column :reports, :incumbent_id
  end
end
