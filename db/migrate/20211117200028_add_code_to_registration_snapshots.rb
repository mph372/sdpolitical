class AddCodeToRegistrationSnapshots < ActiveRecord::Migration[5.2]
  def change
    add_column :registration_snapshots, :district_code, :string
  end
end
