class DropVendorsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :vendors
  end

  def down
    create_table :vendors, force: :cascade do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :full_name
      t.bigint :committee_id
      t.index ["committee_id"], name: "index_vendors_on_committee_id"
    end
  end
end
