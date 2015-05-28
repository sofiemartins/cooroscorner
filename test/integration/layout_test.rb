require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest

  test "root layout" do 
    get root_path
    assert_template "welcome/index"
    assert_select('a[href="/"]') do |elements|
      elements.count == 1
    end
    assert_select('a[href="/archive"]') do |elements|
      elements.count == 1
    end
    assert_select('a[href="/about"]') do |elements|
      elements.count == 1
    end
    assert_select('a[href="/offensive"]') do |elements|
      elements.count == 2
    end
    assert_select('a[href="/random"]') do |elements|
      elements.count == 2
    end
    assert_select('a[href="/mayuyu"]') do |elements|
      elements.count == 2
    end
    assert_select('a[href="/tina"]') do |elements|
      elements.count == 2
    end
  end

end
