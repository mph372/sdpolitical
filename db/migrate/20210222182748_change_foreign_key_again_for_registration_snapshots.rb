class ChangeForeignKeyAgainForRegistrationSnapshots < ActiveRecord::Migration[5.2]
  def change
    rename_column :registration_snapshots, :statistical_datum_id_id, :statistical_datum_id
  end
end
