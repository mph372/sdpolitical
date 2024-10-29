Rails.application.configure do
  config.cache_classes = true
  config.cache_store = :memory_store, { size: 64.megabytes }
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :terser
  config.assets.compile = true
  config.active_storage.service = :local
  config.log_level = :debug
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.logger = ActiveSupport::Logger.new(STDOUT)
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  # AWS SES Configuration
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default charset: 'utf-8'
  config.action_mailer.default_options = {
    from: 'theballotbook@theballotbook.com'
  }

  config.action_mailer.smtp_settings = {
    address: 'email-smtp.us-west-1.amazonaws.com',
    port: 587,
    user_name: ENV['SES_SMTP_USERNAME'],
    password: ENV['SES_SMTP_PASSWORD'],
    authentication: :plain,
    enable_starttls_auto: true,
    domain: 'theballotbook.com',
    openssl_verify_mode: 'none'  # Add this for debugging SSL issues
  }

  config.action_mailer.default_url_options = { 
    host: 'theballotbook.com', 
    protocol: 'https' 
  }

  # Add detailed logging for SMTP
  config.action_mailer.logger = Logger.new(STDOUT)
  config.action_mailer.logger.level = Logger::DEBUG

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
  config.force_ssl = true
end