class DashboardPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize(candidates)
        super :page_layout => :landscape
        @candidates = candidates
        logo = "#{Rails.root}/app/assets/images/logos/ballot.png"
        image logo, :position => :center, :scale => 0.25
        text "Campaign Finance Report", size: 15, style: :bold
        recent_fundraising
        aggregate_fundraising
        string = "Generated on #{Time.now.strftime('%m-%d-%Y')}"
    # Green page numbers 1 to 11
        options = { :at => [bounds.right - 150, 0],
        :width => 150,
        :align => :right,
        :size => 10 }
        number_pages string, options
        end

    end

    def tracked_candidates
        @candidates.each do |candidate|
            move_down 20
            text "#{candidate.first_name} - #{candidate.last_name}"
            text "#{number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_receipts))}"
        end
    end

    def aggregate_fundraising
        move_down 20
        text "Aggregate Fundraising Numbers", size: 12, style: :bold
        table aggregate_fundraising_rows, :cell_style => { :size => 10 }
    end

    def recent_fundraising
        move_down 20
        text "Most Recent Fundraising Report Numbers", size: 12, style: :bold
        table recent_fundraising_rows, :cell_style => { :size => 10 }
    end

    def aggregate_fundraising_rows
        [["Jurisdiction", "District", "Name", "Total Raised", "Total Spent", "Cash-On-Hand", "Net COH", "As of"]] +
        @candidates.select{|c| c.former_candidate == false}.uniq.map do |candidate|
            [candidate.district.jurisdiction.name, candidate.district.district_name, candidate.full_name, number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_receipts)), number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_disbursements)), number_to_currency(candidate.current_cash_on_hand), number_to_currency(candidate.current_net_coh), candidate.period_end]
        end
    end

    def recent_fundraising_rows
        [["Jurisdiction", "District", "Name", "Period Begin", "Period End", "Raised this Period", "Spent this Period"]] +
        @candidates.select{|c| c.former_candidate == false}.uniq.map do |candidate|
            [candidate.district.jurisdiction.name, candidate.district.district_name, candidate.full_name, candidate.period_begin, candidate.period_end, number_to_currency(candidate.period_raised), number_to_currency(candidate.period_spent)]
        end
    end