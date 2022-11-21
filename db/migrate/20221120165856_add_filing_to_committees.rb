class AddFilingToCommittees < ActiveRecord::Migration[5.2]
  def change
    add_column :committees, :filer_id, :integer
  end
end
