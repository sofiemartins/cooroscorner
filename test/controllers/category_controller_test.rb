require 'test_helper'

class CategoryControllerTest < ActionController::TestCase
  include Devise::TestHelpers 

  test "should not get new as unauthorized" do
    assert_raises(ActionController::RoutingError) do
      get :new
    end
  end

  test "should not get new as normal user" do
    user = User.find_by_username("test")
    sign_in user
    assert_raises(ActionController::RoutingError) do
      get :new
    end
  end

  test "should get new as admin" do
    admin = User.find_by_username("testadmin")
    sign_in admin
    assert current_user.admin
    assert_response :success
  end

  test "should render new template as admin" do
    admin = User.find_by_username("testadmin")
    sign_in admin
    assert user_signed_in?
    get :new
    assert_template "new"
  end

end
