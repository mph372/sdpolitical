class AddPeopleToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :person, foreign_key: true
  end
end
