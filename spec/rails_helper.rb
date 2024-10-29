# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'devise'

# Add additional requires below this line. Rails is not loaded until this point!

# Add support files
Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # Include Factory Bot syntax methods
  config.include FactoryBot::Syntax::Methods
  
  # Include Devise test helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request

  # Configure default url options for tests
  config.before(:each) do
    ActionMailer::Base.default_url_options = { host: 'localhost:3000' }
  end

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  config.before(:each) do
    # Configure ActiveJob to use test adapter
    ActiveJob::Base.queue_adapter = :test
    # Clear any enqueued jobs
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear
    # Clear any performed jobs
    ActiveJob::Base.queue_adapter.performed_jobs.clear
    # Clear any delivered emails
    ActionMailer::Base.deliveries.clear
  end
end