require 'test_helper'

class ComicsControllerTest < ActionController::TestCase
  test "should get archive" do
    get :archive
    assert_response :success
  end

end
