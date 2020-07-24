class AddSeatsToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :is_seat, :boolean, :default => false
  end
end
