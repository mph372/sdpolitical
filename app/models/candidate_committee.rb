class CandidateCommittee < ApplicationRecord
    belongs_to :person
    has_many :reports 
end
