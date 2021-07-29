class ChangeEndorsementOnCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :party_endorsement, :string
    add_column :candidates, :party_registration, :string
    remove_column :candidates, :endorsed_republican
    remove_column :candidates, :endorsed_democrat
  end
end
