require 'test_helper'

class Manage::NewslettersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_newsletters_index_url
    assert_response :success
  end

end
