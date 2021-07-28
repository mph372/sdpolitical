class Jurisdiction < ApplicationRecord
    has_many :districts
    has_many :measures
    # has_many :candidates, through: :districts
    has_many :expenditures, through: :districts
    has_many :people, through: :districts
    has_many :campaigns, through: :districts
    has_many :candidates, through: :campaigns 
    has_many :reports, through: :people
    has_many :committees
    has_many :election_histories, through: :districts 
    has_many :former_offices, through: :districts 
    belongs_to :registration_history, optional: true
    has_many :statistical_datum
    has_many :registration_snapshots, through: :statistical_datum
    has_one :campaign_finance_module

    def person
        districts.collect{|u| u.person}
    end

    def at_large_election_histories
     election_histories.where('at_large_history == ?', true)
    end
end
