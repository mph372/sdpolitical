class AddBirthDateFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :birth_day, :integer
    add_column :people, :birth_month, :integer
  end
end
