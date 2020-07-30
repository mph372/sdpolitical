class AddPdfToExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_column :expenditures, :pdf, :string
  end
end
