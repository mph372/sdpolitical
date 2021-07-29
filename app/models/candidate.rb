class Candidate < ApplicationRecord
  belongs_to :campaign
  belongs_to :person
  has_one :candidate_committee

  def vote_share
    calculation = (votes.to_f / campaign.total_votes) * 100
    "#{calculation.round(2)}%"
  end

  def display_name
    if person.present?
      "#{person.full_name} #{party_abbreviation}"
    else
      "#{first_name} #{last_name} #{party_abbreviation}"
    end
  end


    def party_abbreviation
      if party_registration != nil
        if party_registration == "Republican"
          "(R)"
        elsif party_registration == "Democrat"
          "(D)"
        elsif party_registration == "Declined to State"
          "(DTS)"
        elsif party_registration == "Green"
          "(GREEN)"
        elsif party_registration == "Peace & Freedom"
          "(P & F)"
        elsif party_registration == "Libertarian"
          "(LIB)"
        elsif party_registration == "Reform"
          "(REF)"
        elsif party_registration == "Natural Law"
          "(NL)"
        elsif party_registration == "American Independent"
          "(AIP)"      
        else
          "(Unknown)"    
        end
      else
      end
    end

end
