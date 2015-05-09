require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest

  test "root layout" do
    get root_path
    assert_template 'welcome/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", archive_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", offensive_path
    assert_select "a[href=?]", random_path
    assert_select "a[href=?]", mayuyu_path
    assert_select "a[href=?]", tina_path
  
    if user_signed_in?
      assert_select "a[href=?]", login_path, count: 0
    else
      assert_select "a[href=?]", login_path
    end
    
  end

end
