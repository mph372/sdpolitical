require "test_helper"

class ContestsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get contests_show_url
    assert_response :success
  end
end
