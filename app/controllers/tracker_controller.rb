class TrackerController < ApplicationController
    before_action :authenticate_user!
    before_action :is_subscriber?

    def index
        @tracked_districts = current_user.tracker_additions
    end

    def is_subscriber?
        redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
      end

end
