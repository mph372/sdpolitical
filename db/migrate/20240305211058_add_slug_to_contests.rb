class AddSlugToContests < ActiveRecord::Migration[6.1]
  def change
    add_column :contests, :slug, :string
    add_index :contests, :slug, unique: true
  end
end
