require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest

  test "root layout" do
    get root_path
    assert_template 'welcome/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", archive_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", offensive_path, count: 2
    assert_select "a[href=?]", random_path, count: 2
    assert_select "a[href=?]", mayuyu_path, count: 2
    assert_select "a[href=?]", tina_path, count: 2
  
    # test the login link! 
  end

end
