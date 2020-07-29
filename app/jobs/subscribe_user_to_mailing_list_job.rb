class SubscribeUserToMailingListJob < ActiveJob::Base
    queue_as :default
    require 'gibbon'

    def perform(user)
    
        gibbon = Gibbon::Request.new(api_key: Rails.application.credentials.mailchimp_api_key)
        gibbon.timeout = 10
        gibbon.lists("b9b4bc4df8").members.create(
            body: {
                email_address: user.email,
                status: "subscribed",
                merge_fields: {FNAME: user.first_name, LNAME: user.last_name}
            }
        )
    end


end