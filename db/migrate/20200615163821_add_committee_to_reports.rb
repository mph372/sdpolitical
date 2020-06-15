class AddCommitteeToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :committee, foreign_key: true
  end
end
