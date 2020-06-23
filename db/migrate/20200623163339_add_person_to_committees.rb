class AddPersonToCommittees < ActiveRecord::Migration[5.2]
  def change
    add_reference :committees, :person, foreign_key: true
  end
end
