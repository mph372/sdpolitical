class AddImageToIncumbents < ActiveRecord::Migration[5.2]
  def change
    add_column :incumbents, :image, :string
  end
end
