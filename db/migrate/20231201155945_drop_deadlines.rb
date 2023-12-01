class DropDeadlines < ActiveRecord::Migration[6.1]
  def up
    drop_table :deadlines
  end

  def down
    create_table :deadlines do |t|
      t.string :title
      t.string :description
      t.date :deadline_date

      t.timestamps
    end
  end
end
