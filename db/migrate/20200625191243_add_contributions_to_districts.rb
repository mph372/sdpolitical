class AddContributionsToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :contribution_limit, :integer
    add_column :districts, :corporate_contributions, :boolean
    add_column :districts, :pac_contributions, :boolean
    add_column :districts, :party_contributions, :boolean
    add_column :districts, :party_contribution_limit, :integer
  end
end
