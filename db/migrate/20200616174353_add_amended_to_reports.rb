class AddAmendedToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :is_amended, :boolean
  end
end
