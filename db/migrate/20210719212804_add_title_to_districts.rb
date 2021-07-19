class AddTitleToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :district_title, :string
  end
end
