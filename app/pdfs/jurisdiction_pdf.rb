class JurisdictionPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize(jurisdiction)
        super :page_layout => :landscape
        @districts = jurisdiction.districts
        logo = "#{Rails.root}/app/assets/images/logos/ballot.png"
        image logo, :position => :center, :scale => 0.25
        move_down 20
        text "Campaign Finance Report for #{jurisdiction.name}", size: 15, style: :bold
        district_display
        string = "Generated on #{Time.now.strftime('%m-%d-%Y')}"
    # Green page numbers 1 to 11
        options = { :at => [bounds.right - 150, 0],
        :width => 150,
        :align => :right,
        :size => 10 }
        number_pages string, options
        end

    end

    def district_display
        @districts.order('district ASC').each do |district|
            if district.campaigns.active.present?
            move_down 20
            text "#{district.district_name}", style: :bold
            table candidate_rows(district), :cell_style => { :size => 10 }
            end
        end 
    end

    def candidate_rows(district)
        candidates = district.campaigns.active.last.candidates
        [["Name", "Total Raised", "Total Spent", "Cash-On-Hand", "Debt", "As of"]] +
        candidates.map do |candidate|
            if candidate.person.has_reports
            reports = candidate.person.all_reports
            [ "#{candidate.person.full_name} #{candidate.person.party_abbreviation}", number_to_currency(reports.sum(:period_receipts)), number_to_currency(reports.sum(:period_disbursements)), number_to_currency(reports.order('period_end DESC').first.current_coh), number_to_currency(reports.order('period_end DESC').first.current_debt), reports.order('period_end DESC').first.period_end]
            else
            [ "#{candidate.person.full_name} #{candidate.person.party_abbreviation}", "$0.00", "$0.00", "$0.00", "$0.00", "N/A"]
            end
        end
    end

    def aggregate_fundraising
        move_down 20
        text "Aggregate Fundraising Numbers", size: 12, style: :bold
        table aggregate_fundraising_rows, :cell_style => { :size => 10 }, header: true
    end

    def recent_fundraising
        move_down 20
        text "Most Recent Fundraising Report Numbers", size: 11, style: :bold
        table recent_fundraising_rows, :cell_style => { :size => 10 }, header: true
    end

    def aggregate_fundraising_rows
        [["Office", "Name", "Total Raised", "Total Spent", "Cash-On-Hand", "Net COH", "As of"]] +
        @candidates.select{|c| c.former_candidate == false}.uniq.map do |candidate|
            [candidate.district.jurisdiction_district_name, candidate.full_name, number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_receipts)), number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_disbursements)), number_to_currency(candidate.current_cash_on_hand), number_to_currency(candidate.current_net_coh), candidate.period_end]
        end
    end

    def recent_fundraising_rows
        [["Office", "Name", "Begin", "End", "Period Raised", "Period Spent", "Total Raised", "Total Spent", "COH", "Net COH"]] +
        @candidates.select{|c| c.former_candidate == false}.uniq.map do |candidate|
            [candidate.district.jurisdiction_district_name, candidate.full_name, candidate.period_begin, candidate.period_end, number_to_currency(candidate.period_raised), number_to_currency(candidate.period_spent), number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_receipts)), number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_disbursements)), number_to_currency(candidate.current_cash_on_hand), number_to_currency(candidate.current_net_coh)]
        end
    end