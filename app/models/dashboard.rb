class Dashboard < ApplicationRecord

    def dashboard_name
        "#{current_user.first_name} #{current_user.last_name}'s Dashboard"
    end

end