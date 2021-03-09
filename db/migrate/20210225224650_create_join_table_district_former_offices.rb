class CreateJoinTableDistrictFormerOffices < ActiveRecord::Migration[5.2]
  def change
    create_table :districts_former_offices, id: false do |t|
      t.bigint :district_id
      t.bigint :former_office_id
    end

    add_index :districts_former_offices, :district_id
    add_index :districts_former_offices, :former_office_id
  end
end
