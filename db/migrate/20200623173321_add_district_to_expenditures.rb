class AddDistrictToExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenditures, :district, foreign_key: true
  end
end
