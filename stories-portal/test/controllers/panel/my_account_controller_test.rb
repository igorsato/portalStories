require 'test_helper'

class Panel::MyAccountControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_my_account_index_url
    assert_response :success
  end

end
