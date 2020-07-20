class DistrictPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize(district)
        super()
        @district = district
        district_header
        if @district.at_large_district?
            incumbent_atlarge
        elsif @district.at_large_district == false
        incumbent_not_atlarge
        end
        registration_table
        past_performance
        campaign_finance
        if @district.at_large_district == false
        district_candidates
        else
        at_large_district_candidates
        end
    end

    def district_header
        if @district.district != "At Large"
        text "#{@district.jurisdiction.name}, #{@district.name} - #{@district.district.to_i.ordinalize} District", size: 15, style: :bold 
        else
        text "#{@district.jurisdiction.name}, #{@district.name}", size: 15, style: :bold
        end
    end

    def registration_table
        move_down 20
        text "Registration Breakdown", style: :bold
        move_down 5
        text "Democrat:...... #{@district.dem_voters.truncate(2)}%"
        text "Republican:.... #{@district.rep_voters.truncate(2)}%"
        text "Other:............. #{@district.other_voters.truncate(2)}%"
        if @district.registration_advantage > 0 
        text "Advantage:..... D +#{@district.registration_advantage.abs.truncate(2)}%"
        else
        text "Advantage:..... R +#{@district.registration_advantage.abs.truncate(2)}%"
        end
    end

    def incumbent_not_atlarge
        text "Incumbent: #{@district.incumbent.first_name} #{@district.incumbent.last_name} (#{@district.incumbent.party}) - Term Expires: #{@district.incumbent.term_expires}"
    end

    def incumbent_atlarge
        @district.jurisdiction.incumbents.each do |incumbent|
            if incumbent.incumbent_district.at_large_district?
            text "Incumbent: #{incumbent.first_name} #{incumbent.last_name} (#{incumbent.party}) - Term Expires: #{incumbent.term_expires}"
            end
        end
    end

    def past_performance
        move_down 20
        text "Past Performance", style: :bold
        if @district.newsom_percent.present?
            if @district.gov_2018 > 0
                text "2018 Governor: Newsom +#{@district.gov_2018.abs.truncate(2)}%" 
            else
                text "2018 Governor: Cox +#{@district.gov_2018.abs.truncate(2)}%"
            end
        end
        if @district.clinton_percent.present?
            if @district.pres_2016 > 0
                text "2016 President: Clinton +#{@district.pres_2016.abs.truncate(2)}%" 
            else
                text "2016 President: Trump +#{@district.pres_2016.abs.truncate(2)}%"
            end
        end
        if @district.brown_percent.present?
            if @district.gov_2014 > 0
                text "2014 Governor: Brown +#{@district.gov_2014.abs.truncate(2)}%" 
            else
                text "2014 Governor: Kashkari +#{@district.gov_2014.abs.truncate(2)}%"
            end
        end
        if @district.obama_percent.present?
            if @district.pres_2012 > 0
                text "2016 President: Obama +#{@district.pres_2012.abs.truncate(2)}%" 
            else
                text "2016 President: Romney +#{@district.pres_2012.abs.truncate(2)}%"
            end
        end
    end

    def campaign_finance
        move_down 20 
        text "Campaign Finance Rules", style: :bold
        if @district.contribution_limit == 0 || @district.contribution_limit == nil
            text "Contribution Limit: No Limit"
        else
            text "Contribution Limit: $#{@district.contribution_limit}"
        end
        if @district.corporate_contributions?
            text "Corporate Contributions: Allowed"
        else
            text "Corporate Contributions: Prohibited"
        end
        if @district.pac_contributions?
            text "PAC Contributions: Allowed"
        else
            text "PAC Contributions: Prohibited"
        end
        if @district.party_contribution_limit == 0 || @district.party_contribution_limit == nil
            text "Party Contribution Limit: No Limit"
        else
            text "Party Contribution Limit: $#{@district.party_contribution_limit}"
        end
    end

    def district_candidates
        move_down 20
        if (@district.incumbent.present? && @district.incumbent.running_reelection == true) || @district.candidates.present?
            text "Candidates for this District/Office", style: :bold
            if @district.incumbent.present? && @district.incumbent.running_reelection?
                if @district.incumbent.reports.present?
                text "#{@district.incumbent.first_name} #{@district.incumbent.last_name} (#{@district.incumbent.party}), #{@district.incumbent.ballot_status} - #{number_to_currency(@district.incumbent.reports.where(candidate_report: true).most_recent.current_coh)} COH"
                else
                text  "#{@district.incumbent.first_name} #{@district.incumbent.last_name} (#{@district.incumbent.party}), #{@district.incumbent.ballot_status} - $0.00 COH"
                end
            end
            @district.candidates.each do |candidate|
                if candidate.on_ballot? && candidate.reports.where(candidate_report: true).present?
                text "#{candidate.first_name} #{candidate.last_name} (#{candidate.party}), #{candidate.ballot_status} - #{number_to_currency(candidate.reports.where(candidate_report: true).most_recent.current_coh)} COH"
                elsif candidate.on_ballot?
                text  "#{candidate.first_name} #{candidate.last_name} (#{candidate.party}), #{candidate.ballot_status} - $0.00 COH"
                end
            end
        end
    end

    def at_large_district_candidates
        move_down 20
        if (@district.incumbent.present? && @district.incumbent.running_reelection == true) || @district.candidates.present?
            text "Candidates for this District/Office", style: :bold
            @district.jurisdiction.incumbents.where(:running_reelection => true).each do |incumbent|
                if incumbent.incumbent_district.term_expires.to_s == "2020" && incumbent.incumbent_district.at_large_district?
                    if incumbent.reports.present?
                    text "#{incumbent.first_name} #{incumbent.last_name} (#{incumbent.party}), #{incumbent.ballot_status} - #{number_to_currency(incumbent.reports.where(candidate_report: true).most_recent.current_coh)} COH"
                    else
                    text  "#{incumbent.first_name} #{incumbent.last_name} (#{incumbent.party}), #{incumbent.ballot_status} - $0.00 COH"
                    end
                end

            end
            @district.jurisdiction.candidates.each do |candidate|
                if candidate.district.term_expires.to_s == "2020" && candidate.district.at_large_district?
                    if candidate.on_ballot? && candidate.reports.present?
                        text "#{candidate.first_name} #{candidate.last_name} (#{candidate.party}), #{candidate.ballot_status} - #{number_to_currency(candidate.reports.where(candidate_report: true).most_recent.current_coh)} COH"
                        elsif candidate.on_ballot?
                        text  "#{candidate.first_name} #{candidate.last_name} (#{candidate.party}), #{candidate.ballot_status} - $0.00 COH"
                    end
                end
            end

        end
    end


end