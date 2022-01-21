class CandidateCommittee < ApplicationRecord
    belongs_to :person
    has_one :candidate
    has_many :reports 
    before_save :only_one_primary

    def committee_status
        if status == "Open"
            
        elsif status == "Closed"
            "(Inactive)"
        end
    end

   scope :is_primary, -> {where(:primary_committee => true)}

    def only_one_primary
        if self.primary_committee?
        self.person.candidate_committees.is_primary.update_all(:primary_committee => false)
        end
    end
end
