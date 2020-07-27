class PricingController < ApplicationController
    before_action :authorize_admin
    
    layout "subscribe"

    def index
    end
end