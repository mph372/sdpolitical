class AddMostRecentTurnoutToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :registration_2020, :integer
    add_column :districts, :voted_2020, :integer
  end
end
