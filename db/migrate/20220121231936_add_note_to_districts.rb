class AddNoteToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :note, :string
  end
end
