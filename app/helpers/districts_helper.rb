module DistrictsHelper
    def user_add_to_tracker? user, book 
        user.trackers.where(user: user, district: district).any?
    end
end
