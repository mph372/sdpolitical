class RemoveIncumbentsFromReports < ActiveRecord::Migration[5.2]
  def change
    
    remove_index :reports, :incumbent_id
  end
end
