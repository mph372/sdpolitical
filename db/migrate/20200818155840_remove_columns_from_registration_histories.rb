class RemoveColumnsFromRegistrationHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :registration_histories, :total_2010, :integer
    remove_column :registration_histories, :gop_2010, :integer
    remove_column :registration_histories, :dem_2010, :integer
  end
end
