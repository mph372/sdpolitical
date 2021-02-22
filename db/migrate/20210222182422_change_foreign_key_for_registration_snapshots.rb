class ChangeForeignKeyForRegistrationSnapshots < ActiveRecord::Migration[5.2]
  def change
    rename_column :registration_snapshots, :statistical_data_id, :statistical_datum_id_id
  end
end
