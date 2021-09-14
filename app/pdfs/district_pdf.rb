class DistrictPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize(district)
        super()
        @district = district
        
 
        logo = "#{Rails.root}/app/assets/images/logos/ballot.png"
        image logo, :position => :center, :scale => 0.25
        move_down 5
        text "www.TheBallotBook.com", align: :center, size: 10
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
        district_candidates
        move_down 20
        if (@district.jurisdiction.statistical_datum.present? && @district.is_at_large) || @district.statistical_datum.present?
           registration
           move_down 20
           past_performance
           
           
        end
            
        
        campaign_finance
        
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

    def registration
        text "Registration Breakdown", style: :bold
        table registration_rows, :cell_style => { :size => 10 }
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
        text "Past Performance", style: :bold
        table past_performance_rows, :cell_style => { :size => 10 }
    end

    def past_performance_rows
        if @district.is_at_large == true  
            statistical_datum = StatisticalDatum.find_by(jurisdiction_id: @district.jurisdiction)
        elsif @district.is_at_large == false  
            statistical_datum = StatisticalDatum.find_by(district_id: @district) 
        end
        ([
            ["2020 President", "#{statistical_datum.pres_2020_result}"],
            ["2018 Governor", "#{statistical_datum.gov_2018_result}"],
            ["2016 President", "#{statistical_datum.pres_2016_result}"],
            ["2014 Governor", "#{statistical_datum.gov_2014_result}"],
            ["2012 President", "#{statistical_datum.pres_2012_result}"],
        ])
    
    end

    def registration_rows

        if @district.is_at_large == true  
            registration_snapshot = RegistrationSnapshot.all.order("snapshot_date desc").limit(1).find_by(statistical_datum_id: @district.jurisdiction.statistical_datum)
        elsif @district.is_at_large == false  
            registration_snapshot = RegistrationSnapshot.all.order("snapshot_date desc").limit(1).find_by(statistical_datum_id: @district.statistical_datum)
        end
         ([
            ["Total Voters", "#{number_with_delimiter(registration_snapshot.total_registered, :delimiter => ',')}"],
            ["Democrat", "#{number_with_precision(registration_snapshot.democrat_percentage, precision: 2)}%"],
            ["Republican", "#{number_with_precision(registration_snapshot.republican_percentage, precision: 2)}%"],
            ["Other", "#{number_with_precision(registration_snapshot.other_percentage, precision: 2)}%"],
            if @district.registration_advantage > 0 
                ["Advantage", "D +#{number_with_precision(registration_snapshot.registration_advantage.abs, precision: 2)}%"]
            else
                ["Advantage", "R +#{number_with_precision(registration_snapshot.registration_advantage.abs, precision: 2)}%"]
            end
        ])

    end


    def campaign_finance
        move_down 20 
        text "Campaign Contribution Limits", style: :bold
        table campaign_finance_rows, :cell_style => { :size => 10 }
    end

    def campaign_finance_rows
        if @district.campaign_finance_module.present?
            district = @district.campaign_finance_module
        elsif @district.jurisdiction.campaign_finance_module.present?
            district = @district.jurisdiction.campaign_finance_module    
        end    
        ([
            ["Contribution Limit", "#{district.contribution_limit_output}"],
            ["Corporate Contributions", "#{district.corporate_contribution_output}"],
            ["PAC Contributions", "#{district.pac_contribution_output}"],
            ["Party Contribution Limit", "#{district.party_contribution_limit_output}"],
        ])
    end

    def district_candidates
        move_down 20
        text "Current Candidates", style: :bold
        table candidate_rows, :cell_style => { :size => 10 }
    end 



    def candidate_rows
        if @district.is_at_large == false
            candidates = @district.campaigns.active.last.candidates
        else
            candidates = @district.jurisdiction.campaigns.active.last.candidates
        end
        [[ "Name", "Total Raised", "Total Spent", "Cash-On-Hand", "As Of"]] +
        candidates.map do |candidate|
            if candidate.person.has_reports
            reports = candidate.person.all_reports
            [ "#{candidate.person.full_name} #{candidate.person.party_abbreviation}", number_to_currency(reports.sum(:period_receipts)), number_to_currency(reports.sum(:period_disbursements)), number_to_currency(reports.order('period_end DESC').first.current_coh), reports.order('period_end DESC').first.period_end]
            else
            [ candidate.person.full_name, "$0.00", "$0.00", "$0.00", "N/A"]
            end
        end
    end

    

    


end