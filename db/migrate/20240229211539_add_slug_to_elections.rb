class AddSlugToElections < ActiveRecord::Migration[6.1]
  def change
    add_column :elections, :slug, :string
    add_index :elections, :slug, unique: true
  end
end
