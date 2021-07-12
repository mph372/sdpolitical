class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.date :period_begin
      t.date :period_end
      t.string :current_cycle

      t.timestamps
    end
  end
end
