require 'test_helper'

class Manage::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manage_customers_index_url
    assert_response :success
  end

  test "should get show" do
    get manage_customers_show_url
    assert_response :success
  end

  test "should get new" do
    get manage_customers_new_url
    assert_response :success
  end

end
