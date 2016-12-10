require 'test_helper'

class Panel::MyOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_my_orders_index_url
    assert_response :success
  end

end
