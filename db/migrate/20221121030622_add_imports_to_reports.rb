class AddImportsToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :import, foreign_key: true
  end
end
