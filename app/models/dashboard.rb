class Dashboard < ApplicationRecord
    has_many :expenditures, through: :persons
    
    def dashboard_name
        "#{current_user.first_name} #{current_user.last_name}'s Dashboard"
    end

end