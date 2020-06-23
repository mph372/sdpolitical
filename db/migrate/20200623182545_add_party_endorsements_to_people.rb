class AddPartyEndorsementsToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :endorsed_republican, :boolean
    add_column :people, :endorsed_democrat, :boolean
  end
end
