module DistrictsHelper
    def user_add_to_dashboard? user, district 
        user.dashboards.where(user: user, district: @district).any?
    end
end
