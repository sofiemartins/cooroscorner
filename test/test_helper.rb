ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers

  fixtures :all

  def log_in_admin
    post login_path, user: { username: "testadmin",
				password: "Sealupthemouthofoutrageforawhile"}
  end

  def log_in_user
    post login_path, user: { username: "test",
				password: "testpasswordhorseandroid" }
  end

  def log_out
    get logout_path
  end

end
