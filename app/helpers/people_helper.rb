module PeopleHelper
    def display_name_link(person, page_source)
      if page_source == "district"
        link_to "#{person.full_name} #{person.party_abbreviation}", person
      else
        "#{person.full_name} #{person.party_abbreviation}"
      end
    end
  
    def display_district_info(person)
      return link_to "#{person.district.district_title}", person.incumbent_district, class: "nounderline" if person.incumbent_district.district == "At Large"
  
      district_title = "#{person.district.district_title}"
      district_type = if person.incumbent_district.is_seat
                        "Seat #{person.incumbent_district.district}"
                      elsif person.incumbent_district.is_area
                        "Trustee Area #{person.incumbent_district.district}"
                      else
                        "#{person.incumbent_district.district.to_i.ordinalize} District"
                      end
  
      link_to "#{district_title}, #{district_type}", person.incumbent_district, class: "nounderline"
    end
  
    def display_candidate_for(person)
      "#{person.campaign.district.jurisdiction.name} - #{person.campaign.district.district_name}"
    end
  
    def display_former_office(person)
      former_office = person.former_offices.order("end_year desc").first
      link_to former_office.header_former_office_name, former_office.true_former_office
    end
  
    def display_birthdate(person)
      if person.birthday_unknown
        "Unknown"
      else
        "#{person.birthdate.to_formatted_s(:long)} (Age #{person.calculated_age})"
      end
    end
  
    def display_term_expiration(person)
      expiration = "#{person.district.term_expires}"
      expiration += " (Term Limited in #{person.term})" if person.term?
      expiration
    end

    def display_name(person, page_source)
      if page_source == :district
        link_to person.full_name_with_party, person
      else
        person.full_name_with_party
      end
    end
  
    def full_name_with_party(person)
      "#{person.first_name} #{person.last_name} #{person.party_abbreviation}"
    end
  end
  