class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :districts, :kashkar_percent, :kashkari_percent
  end
end
