Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Mail settings
  config.action_mailer.perform_caching = false
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp

  # Mail defaults
  config.action_mailer.default_url_options = { 
    host: 'localhost:3000', 
    protocol: 'http'
  }

  config.action_mailer.default_options = {
    from: 'theballotbook@theballotbook.com',
    reply_to: 'theballotbook@theballotbook.com'
  }

  # AWS SES SMTP settings
  config.action_mailer.smtp_settings = {
    address: 'email-smtp.us-west-1.amazonaws.com',
    port: 587,
    user_name: 'AKIAWF556RAFPWIZTQWY',
    password: 'BBS2tMrLdKRwVe/XCfZ1PfTwNTowF2cRavCzYYYaQ8Qz',
    domain: 'theballotbook.com',
    authentication: :plain,
    enable_starttls_auto: true,
    openssl_verify_mode: 'peer'  # Added explicit SSL verification
  }

  # Ensure mail errors are logged
  config.action_mailer.logger = ActiveSupport::Logger.new(STDOUT)
  config.action_mailer.logger.level = Logger::DEBUG

  # Use a real queuing backend for Active Job
  config.active_job.queue_adapter = :inline
end

