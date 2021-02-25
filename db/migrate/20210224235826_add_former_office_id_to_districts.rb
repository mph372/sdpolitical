class AddFormerOfficeIdToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_reference :districts, :former_office, foreign_key: true
  end
end
