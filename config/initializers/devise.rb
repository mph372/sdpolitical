# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = '"The Ballot Book" <theballotbook@theballotbook.com>'
  
  require 'devise/orm/active_record'
  
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  
  config.stretches = Rails.env.test? ? 1 : 11
  
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  
  config.reset_password_within = 6.hours
  
  config.sign_out_via = :delete

  # Added settings for email confirmation
  config.allow_unconfirmed_access_for = 0.days # Requires email confirmation before access
  config.confirm_within = 2.days # Token expires after 2 days
  config.clean_up_csrf_token_on_authentication = true
  
  # Email change confirmation
  config.send_email_changed_notification = true
  config.send_password_change_notification = true
end