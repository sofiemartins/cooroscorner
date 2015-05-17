require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest

  test "should not log in with wrong password" do
    setup
    post login_path, user: { username: "test", 
				password: "wrong_password" }
  end

  test "should log in with valid password" do
    setup
    post login_path, user: { username: "test", 
				password: "testpasswordhorseandroid" }
  end

  private 

    def setup
      if !User.find_by_username("test")
        post register_path, user: { email: "test1@example.com",
				username: "test",
				password: "testpasswordhorseandroid",
				password_confirmation: "testpasswordhorseandroid" }
      end
    end

end
