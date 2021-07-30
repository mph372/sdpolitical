class AddActiveToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :active, :boolean
  end
end
