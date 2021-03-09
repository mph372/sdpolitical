class CreateDistrictFormerOffices < ActiveRecord::Migration[5.2]
  def change
    create_table :district_former_offices do |t|
      t.references :district, foreign_key: true
      t.references :former_office, foreign_key: true

      t.timestamps
    end
  end
end
