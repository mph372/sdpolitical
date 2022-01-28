class Candidate < ApplicationRecord
  belongs_to :campaign
  # delegate :person, to: :campaign
  belongs_to :person, optional: true
  belongs_to :candidate_committee, optional: true


  def display_ballot_title
    if ballot_title != nil 
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
    if campaign.election_date >= Date.today
    update_attribute(:active, true)
    else
    update_attribute(:active, false)
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
          "(P&F)"
        elsif party_registration == "Libertarian"
          "(LIB)"
        elsif party_registration == "Reform"
          "(REF)"
        elsif party_registration == "Natural Law"
          "(NL)"
        elsif party_registration == "American Independent"
          "(AIP)"    
        elsif party_registration == "Unknown"
          "(N/A)"   
        elsif party_registration == ""
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
