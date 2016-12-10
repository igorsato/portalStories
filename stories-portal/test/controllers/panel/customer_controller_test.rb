require 'test_helper'

class Panel::CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_customer_index_url
    assert_response :success
  end

end
