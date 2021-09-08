class Candidate < ApplicationRecord
  belongs_to :campaign
  # delegate :person, to: :campaign
  belongs_to :person, optional: true
  has_one :candidate_committee

  def vote_share
    if campaign.election_date < Date.today && votes != nil
    calculation = (votes.to_f / campaign.total_votes) * 100
    "#{calculation.round(2)}%"
    else 
    end
  end

  def display_name
    if person.present?
      "#{person.full_name} #{party_abbreviation}"
    else
      "#{first_name} #{last_name} #{party_abbreviation}"
    end
  end

  def display_vote_share
    if campaign.election_date < Date.today && votes != nil
    "#{number_with_delimiter(self.votes, :delimiter => ',')}"
    else
    end
  end

  def active_campaign
    campaign.election_date >= Date.today
  end

  scope :active, -> {where('active = ?', true)}

  def set_active
    if self.campaign.election_date >= Date.today
    self.update_attribute(:active, true)
    else
    self.update_attribute(:active, false)
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
