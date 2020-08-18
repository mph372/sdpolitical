class AddReferencesToJurisdictions < ActiveRecord::Migration[5.2]
  def change
    add_reference :jurisdictions, :registration_history, foreign_key: true
  end
end
