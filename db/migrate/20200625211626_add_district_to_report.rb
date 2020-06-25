class AddDistrictToReport < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :district, foreign_key: true
  end
end
