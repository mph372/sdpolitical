# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => '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',
  :domain => 'theballotbook.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
