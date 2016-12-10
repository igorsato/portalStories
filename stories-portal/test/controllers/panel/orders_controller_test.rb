require 'test_helper'

class Panel::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_orders_index_url
    assert_response :success
  end

end
