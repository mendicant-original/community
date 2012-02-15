ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'test_notifier/runner/minitest'
require 'capybara/rails'
require 'support/services'
require 'support/auth'
require 'support/integration'

TestNotifier.silence_no_notifier_warning = true
OmniAuth.config.test_mode                = true

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Support::Integration
  include Support::Auth

  setup    { mock_uniweb_user({}) }
  teardown { Capybara.reset_sessions! }
end

