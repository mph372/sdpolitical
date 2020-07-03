class TrackerController < ApplicationController
    before_action :authenticate_user!

    def index
        @tracked_districts = current_user.tracker_additions
    end

end
