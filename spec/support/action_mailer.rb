# spec/support/action_mailer.rb
RSpec.configure do |config|
  config.before(:each) do
    ActionMailer::Base.default_url_options = { host: 'localhost:3000' }
  end
end