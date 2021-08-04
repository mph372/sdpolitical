class DistrictPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize(district)
        super()
        @district = district
        logo = "#{Rails.root}/app/assets/images/logos/ballot.png"
        image logo, :position => :center, :scale => 0.25
        district_header
        if @district.person.present?
            if @district.at_large_district?
            incumbent_atlarge
            elsif @district.at_large_district == false
            incumbent_not_atlarge
            end
        else
            vacant_district
        end
        registration_table
        past_performance
        campaign_finance
        if @district.at_large_district == false
        district_candidates
        else
        atlarge_district_candidates
        end
        string = "Generated on #{Time.now.strftime('%m-%d-%Y')}"
        # Green page numbers 1 to 11
            options = { :at => [bounds.right - 150, 0],
            :width => 150,
            :align => :right,
            :size => 10 }
            number_pages string, options
    end

    def vacant_district
        text "Incumbent: VACANT"
    end


    def district_header
        move_down 20
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
        table ([
            ["Democrat", "#{@district.truncated_dem_voters.truncate(2)}%"],
            ["Republican", "#{@district.truncated_rep_voters.truncate(2)}%"],
            ["Other", "#{@district.other_voters.truncate(2)}%"],
            if @district.registration_advantage > 0 
                ["Advantage", "D +#{@district.registration_advantage.abs.truncate(2)}%"]
            else
                ["Advantage", "R +#{@district.registration_advantage.abs.truncate(2)}%"]
            end
        ])
    end

    def incumbent_not_atlarge
        text "Incumbent: #{@district.person.first_name} #{@district.person.last_name} (#{@district.person.party}) - Term Expires: #{@district.term_expires}"
    end

    def incumbent_atlarge
        @district.jurisdiction.incumbents.each do |incumbent|
            if person.district.at_large_district?
            text "Incumbent: #{person.first_name} #{person.last_name} (#{person.party}) - Term Expires: #{person.district.term_expires}"
            end
        end
    end

    def past_performance
        move_down 20
        text "Past Performance", style: :bold
        table past_performance_rows, :cell_style => { :size => 10 }
        

    end

    def past_performance_rows
        ([
            ["2018 Governor", "#{@district.gov_2018_result}"],
            ["2016 President", "#{@district.pres_2016_result}"],
            ["2014 Governor", "#{@district.gov_2014_result}"],
            ["2012 President", "#{@district.pres_2012_result}"],
        ])
    
    end


    def campaign_finance
        move_down 20 
        text "Campaign Finance Rules", style: :bold
        table campaign_finance_rows, :cell_style => { :size => 10 }
    end

    def campaign_finance_rows
        ([
            ["Contribution Limit", "#{@district.contribution_limit_output}"],
            ["Corporate Contributions", "#{@district.corporate_contribution_output}"],
            ["PAC Contributions", "#{@district.pac_contribution_output}"],
            ["Party Contribution Limit", "#{@district.party_contribution_limit_output}"],
        ])
    end

    def district_candidates
        move_down 20
        text "Current Candidates", style: :bold
        table district_candidates_rows, :cell_style => { :size => 10 }
    end 

    def atlarge_district_candidates
        move_down 20
        text "Current Candidates", style: :bold
        table atlarge_district_candidates_rows, :cell_style => { :size => 10 }
    end

    def district_candidates_rows

        [[ "Name", "Total Raised", "Total Spent", "Cash-On-Hand", "Net COH", "As of"]] +
        @district.campaigns.last.candidates.each do |candidate|
            [ candidate.person.full_name, "Total Raised", "Total Spent", "Cash-On-Hand", "Net COH", "As of"]
        end
    end

    def atlarge_district_candidates_rows

            [["Name", "Total Raised", "Total Spent", "Cash-On-Hand", "Net COH", "As of"]] +
            @district.jurisdiction.candidates.select{|c| c.former_candidate == false }.select{|c| c.district.at_large_district == true }.select{|c| c.is_candidate == true }.map do |candidate|
                [candidate.full_name, number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_receipts)), number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_disbursements)), number_to_currency(candidate.current_cash_on_hand), number_to_currency(candidate.current_net_coh), candidate.period_end]
            end
    end

    

    


end