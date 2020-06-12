class AddColumnsToIncumbents < ActiveRecord::Migration[5.2]
  def change
    add_column :incumbents, :seeking_office, :integer
    add_column :incumbents, :official_website, :string
    add_column :incumbents, :campaign_website, :string
  end
end
