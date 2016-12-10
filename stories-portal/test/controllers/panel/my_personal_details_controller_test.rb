require 'test_helper'

class Panel::MyPersonalDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get panel_my_personal_details_index_url
    assert_response :success
  end

end
