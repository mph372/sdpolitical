class ChangeElectionsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :elections, :year, :integer
    remove_column :elections, :district_id, :bigint
    remove_column :elections, :election_type, :string
    add_column :elections, :election_date, :date
    add_column :elections, :name, :string
  end
end
