require 'test_helper'

class Panel::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_addresses_index_url
    assert_response :success
  end

end
