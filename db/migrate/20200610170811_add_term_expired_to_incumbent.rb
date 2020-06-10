class AddTermExpiredToIncumbent < ActiveRecord::Migration[5.2]
  def change
    add_column :incumbents, :term_expires, :integer
  end
end
