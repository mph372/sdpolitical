class PricingController < ApplicationController
    


    layout "subscribe"

    def index

        set_meta_tags title: 'Pricing',
        site: 'The Ballot Book'
        
    end
end