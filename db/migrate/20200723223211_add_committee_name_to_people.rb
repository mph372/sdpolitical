class AddCommitteeNameToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :incumbent_committee_name, :string
  end
end
