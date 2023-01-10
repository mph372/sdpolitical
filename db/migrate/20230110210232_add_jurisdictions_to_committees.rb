class AddJurisdictionsToCommittees < ActiveRecord::Migration[5.2]
  def change
    add_reference :committees, :jurisdiction, foreign_key: true
  end
end
