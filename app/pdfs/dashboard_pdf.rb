class DashboardPDF < Prawn::Document 
    include ActionView::Helpers::NumberHelper
    def initialize
        super()
        logo = "#{Rails.root}/app/assets/images/logos/ballot.png"
        image logo, :position => :center, :scale => 0.4
        tracked_districts
        end

    end

    def tracked_districts
        @districts.each do |district|
            
            text "#{district.name}"
          
        end
    end