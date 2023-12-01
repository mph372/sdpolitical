module JurisdictionsHelper
    def display_district(incumbent_district)
        return "#{incumbent_district.title}, At Large" if incumbent_district.district == "At Large"
    
        if incumbent_district.is_seat
          "#{incumbent_district.title}, Seat #{incumbent_district.district}"
        elsif incumbent_district.is_area
          "#{incumbent_district.title}, Trustee Area #{incumbent_district.district}"
        else
          "#{incumbent_district.title}, #{incumbent_district.district.to_i.ordinalize} District"
        end
      end
    
      def display_residence(person)
        residence = []
        residence << "CD-#{person.congressional_district}" if person.congressional_district.present?
        residence << "SD-#{person.senate_district}" if person.senate_district.present?
        residence << "AD-#{person.assembly_district}" if person.assembly_district.present?
        residence << "BOS-#{person.supe_district}" if person.supe_district.present?
        residence.join(', ')
      end
end
