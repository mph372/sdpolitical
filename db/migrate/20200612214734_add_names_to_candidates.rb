class AddNamesToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :first_name, :string
    add_column :candidates, :last_name, :string
  end
end
