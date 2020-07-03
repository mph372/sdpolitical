class AddAppointedToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :is_appointed, :boolean
  end
end
