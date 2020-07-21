class ChangeDistrictsColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :districts, :registration_2020, :registered_2020
  end
end
