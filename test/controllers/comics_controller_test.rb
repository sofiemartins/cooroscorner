require 'test_helper'

class ComicsControllerTest < ActionController::TestCase
  test "should get archive" do
    get :archive
    assert_response :success
  end

  test "should get offensive comics" do
    get :offensive
    assert_response :success
  end

  test "should get random comics" do
    get :random
    assert_response :success
  end

  test "should get mayuyu comics" do
    get :mayuyu
    assert_response :success
  end
 
  test "should get tina comics" do
    get :tina
    assert_response :success
  end

end
