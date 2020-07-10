class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :is_subscriber?

    def index
        @dashboard_districts = current_user.dashboard_additions
        @expenditures = current_user.dashboard_additions

    end

    def is_subscriber?
        redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
      end

end
