require 'gibbon'
gibbon = Gibbon::Request.new(api_key: Rails.application.credentials.mailchimp_api_key)
gibbon.timeout = 10