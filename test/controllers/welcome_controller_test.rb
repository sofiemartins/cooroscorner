require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test "should get index" do
    get :index 
    assert_response :success
  end

  test "should render new template" do
    get :index
    assert_template "index"
  end

  test "should get about" do
    get :about
    assert_response :success
  end
 
  test "should render about template" do
    get :about
    assert_template "about"
  end

end
