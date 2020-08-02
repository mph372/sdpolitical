class DashboardPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize(candidates)
        super :page_layout => :landscape
        @candidates = candidates
        logo = "#{Rails.root}/app/assets/images/logos/ballot.png"
        image logo, :position => :center, :scale => 0.4
        text "Campaign Finance Report", size: 15, style: :bold
        line_items
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

    def line_items
        move_down 20
        table line_item_rows, :cell_style => { :size => 10 }
    end

    def line_item_rows
        [["Jurisdiction", "District", "Name", "Total Raised", "Total Spent", "Cash-On-Hand", "Net COH", "As of"]] +
        @candidates.select{|c| c.former_candidate == false}.map do |candidate|
            [candidate.district.jurisdiction.name, candidate.district.district_name, candidate.full_name, number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_receipts)), number_to_currency(candidate.reports.where(:cycle => "2020", candidate_report: true ).sum(:period_disbursements)), number_to_currency(candidate.current_cash_on_hand), number_to_currency(candidate.current_net_coh), candidate.period_end]
        end
    end