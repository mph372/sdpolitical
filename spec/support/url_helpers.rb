# spec/support/url_helpers.rb
module UrlHelpers
  def default_url_options
    { host: 'localhost:3000' }
  end
end

RSpec.configure do |config|
  config.include UrlHelpers, type: :mailer
  config.include UrlHelpers, type: :job
end