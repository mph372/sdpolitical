class ChangeYearFormatInFormerOffice < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :former_offices, :start_year, :integer
      change_column :former_offices, :end_year, :integer
    end
    def down
      change_column :former_offices, :start_year, :date
      change_column :former_offices, :end_year, :date
    end
  end
end
