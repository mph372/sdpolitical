class AddOrgToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :organization_name, :string
  end
end
