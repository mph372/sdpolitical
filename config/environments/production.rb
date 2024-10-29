Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :terser
  config.assets.compile = true
  config.active_storage.service = :local
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  # AWS SES Configuration
# AWS SES Configuration
config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
config.action_mailer.default charset: 'utf-8'
config.action_mailer.default_options = {
  from: 'theballotbook@theballotbook.com'
}

config.action_mailer.smtp_settings = {
  address:              'email-smtp.us-west-1.amazonaws.com',
  port:                 587,
  user_name:           Rails.application.credentials.dig(:aws, :ses_smtp_username),
  password:            Rails.application.credentials.dig(:aws, :ses_smtp_password),
  authentication:       :login,
  enable_starttls_auto: true,
  tls:                 true,
  ssl:                 true
}

config.action_mailer.default_url_options = { host: 'theballotbook.com', protocol: 'https' }
  
  # Update this to use https and remove http:
  config.action_mailer.default_url_options = { host: 'theballotbook.com', protocol: 'https' }

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  config.force_ssl = true
end