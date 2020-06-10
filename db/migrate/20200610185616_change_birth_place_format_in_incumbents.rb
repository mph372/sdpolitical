class ChangeBirthPlaceFormatInIncumbents < ActiveRecord::Migration[5.2]
  def up
    change_column :incumbents, :birth_place, :string
  end

  def down
    change_column :incumbents, :birth_place, :integer
  end
end
