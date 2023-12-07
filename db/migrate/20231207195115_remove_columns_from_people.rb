class RemoveColumnsFromPeople < ActiveRecord::Migration[6.1]
  def change
    remove_column :people, :first_elected, :date
    remove_column :people, :prior_elected, :string
    remove_column :people, :salary, :integer
    remove_column :people, :birthplace, :string
    remove_column :people, :phone, :string
    remove_column :people, :on_ballot, :boolean
    remove_column :people, :term_expires, :integer
    remove_column :people, :seeking_office, :integer
    remove_column :people, :is_incumbent, :boolean
    remove_column :people, :running_reelection, :boolean
    remove_column :people, :endorsed_republican, :boolean
    remove_column :people, :endorsed_democrat, :boolean
    remove_column :people, :ballot_status, :string
    remove_column :people, :running_at_large, :boolean
    remove_column :people, :birth_day, :integer
    remove_column :people, :birth_month, :integer
    remove_column :people, :incumbent_committee_name, :string
    remove_column :people, :campaign_email, :string
  end
end
