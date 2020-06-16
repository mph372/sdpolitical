class CreateOtherdistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :otherdistricts do |t|

      t.timestamps
    end
  end
end
