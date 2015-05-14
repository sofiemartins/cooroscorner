require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post user_registration_path, user: { email: "example@example.com",
				username: "example1",
				password: "testtesttest1",
				password_confirmation: "testtesttest1" }

    end
  end

  test "assert invalid emails won't be accepted" do
    get signup_path
    assert_no_difference 'User.count' do
      post user_registration_path, user: { email:  "@example.com",
				username: "test1",
				password: "testtesttest1",
				password_confirmation: "testtesttest2" }
      post user_registration_path, user: { email: "thisisnotanemailaddress",
				username: "test2",
				password: "testtesttest2",
				password_confirmation: "testtesttest2" }
      post user_registration_path, user: { email: "thisisnotanemail@test.",
				username: "test3",
				password: "testtesttest3",
				password_confirmation: "testtesttest3" }
    end
  end

  test "assert non matching passwords won't be accepted" do
    post user_registration_path, user: { email: "test4@example.com",
				username: "test6",
				password: "testtesttest6",
				password_confirmation: "testtesttest66" }
  end

  test "assert username must be valid" do
    post user_registration_path, user: { email: "test2@example.com",
				username: "t",
				password: "testtesttest4",
				password_confirmation: "testtesttest4" }
    post user_registration_path, user: { email: "test3@example.com", 
				username: "thisnameislongerthan10signs",
				password: "testtesttest5",
				password_confirmation: "testtesttest5" }		
  end

end