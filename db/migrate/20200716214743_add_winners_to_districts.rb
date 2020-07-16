class AddWinnersToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :number_of_winners, :integer
  end
end
