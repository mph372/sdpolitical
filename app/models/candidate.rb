class Candidate < ApplicationRecord
  belongs_to :campaign
  # delegate :person, to: :campaign
  belongs_to :person, optional: true
  belongs_to :candidate_committee, optional: true
  has_many :expenditures
 


  def display_ballot_title
    if ballot_title != "" 
      ballot_title
    else
      if person.district.present? 
        "#{person.district.district_title}, #{person.district.jurisdiction.name}"
      else
        person.professional_career 
      end
    end
  end

  def is_district_incumbent
    if person == campaign.district.person
      "*"
    else
    end
  end

  def vote_share
    if campaign.election_date < Date.today && votes != nil
    calculation = (votes.to_f / campaign.candidates.sum(:votes)) * 100
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

  def reverse_display_name
    if person.present?
      "#{person.last_name}, #{person.first_name} "
    else
      "#{last_name}, #{first_name} "
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
    if campaign.election_date >= Date.today
    update_attribute(:active, true)
    else
    update_attribute(:active, false)
    end
  end

  def display_party
    if person.present?
      person.party
    else
      party_registration
    end
  end


    def party_abbreviation
      if display_party != nil
        if display_party == "Republican"
          "(R)"
        elsif display_party == "Democrat"
          "(D)"
        elsif display_party == "Declined to State"
          "(DTS)"
        elsif display_party == "Green"
          "(GREEN)"
        elsif display_party == "Peace & Freedom"
          "(P&F)"
        elsif display_party == "Libertarian"
          "(LIB)"
        elsif display_party == "Reform"
          "(REF)"
        elsif display_party == "Natural Law"
          "(NL)"
        elsif display_party == "American Independent"
          "(AIP)"    
        elsif display_party == "Unknown"
          "(N/A)"   
        elsif display_party == ""
          ""    
        end
      else
      end
    end



    def total_raised  
      if candidate.person.has_reports
        number_to_currency(candidate.person.all_reports.sum(:period_receipts))
      else
        "$0.00"
      end
    end

    def total_spent
      if candidate.person.has_reports
        number_to_currency(candidate.person.all_reports.sum(:period_disbursements))
      else
        "$0.00"
      end
    end

    def current_coh
      if candidate.person.has_reports
        number_to_currency(candidate.person.all_reports.order('period_end DESC').first.current_coh)
      else
        "$0.00"
      end
    end

    def current_coh
      if candidate.person.has_reports
        number_to_currency(candidate.person.all_reports.order('period_end DESC').first.current_debt)
      else
        "$0.00"
      end
    end

    def last_report
      if candidate.person.has_reports
        number_to_currency(candidate.person.all_reports.order('period_end DESC').first.period_end)
      else
        "N/A"
      end
    end

end
