class AddPartySupportToMeasures < ActiveRecord::Migration[5.2]
  def change
    add_column :measures, :gop_support, :string
    add_column :measures, :dem_support, :string
  end
end
