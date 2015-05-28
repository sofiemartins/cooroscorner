require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  include Devise::TestHelpers

  test "login with invalid information" do
    get login_path
    assert_template 'user/sessions/new'
    post login_path, session: { username: "", password: "" }
    assert_template 'user/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, session: { username: "test", password: "password" }
    assert_redirected_to root_path
    assert user_signed_in?
    assert_select "a[href=?]", preferences_path, count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", login_path, count: 0
  end
end
