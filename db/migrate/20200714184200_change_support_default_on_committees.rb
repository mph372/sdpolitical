class ChangeSupportDefaultOnCommittees < ActiveRecord::Migration[5.2]
  def change
    change_column_default :committees, :support, false
  end
end
