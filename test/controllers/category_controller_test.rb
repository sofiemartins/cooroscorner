require 'test_helper'

class CategoryControllerTest < ActionController::TestCase
  include Devise::TestHelpers 

  test "should not get new as unauthorized" do
    get :new
    assert_response :not_found
  end

  test "should not get new as normal user" do
    log_in_user
    get :new
    assert_response :missing
    log_out
  end

  test "should get new as admin" do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
    get :new
    assert_response :success
  end

end
