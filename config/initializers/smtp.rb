ActionMailer::Base.smtp_settings = {
  domain: 'theballotbook.com',
  address:        "smtp.sendgrid.net",
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  password:       Rails.application.credentials.sendgrid_password
}