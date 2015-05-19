require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest

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
    post login_path, session { username: users(valid1).username, "testpasswordhorseandroid" }
    assert_redirected_to root
    follow_redirect!
    assert_template 'welcome/index'
    assert_select "a[href=?]", preferences_path, count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", login_path, count: 0
  end
end
