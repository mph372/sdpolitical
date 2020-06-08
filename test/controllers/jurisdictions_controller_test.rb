require 'test_helper'

class JurisdictionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jurisdiction = jurisdictions(:one)
  end

  test "should get index" do
    get jurisdictions_url
    assert_response :success
  end

  test "should get new" do
    get new_jurisdiction_url
    assert_response :success
  end

  test "should create jurisdiction" do
    assert_difference('Jurisdiction.count') do
      post jurisdictions_url, params: { jurisdiction: { contribution_limit: @jurisdiction.contribution_limit, name: @jurisdiction.name } }
    end

    assert_redirected_to jurisdiction_url(Jurisdiction.last)
  end

  test "should show jurisdiction" do
    get jurisdiction_url(@jurisdiction)
    assert_response :success
  end

  test "should get edit" do
    get edit_jurisdiction_url(@jurisdiction)
    assert_response :success
  end

  test "should update jurisdiction" do
    patch jurisdiction_url(@jurisdiction), params: { jurisdiction: { contribution_limit: @jurisdiction.contribution_limit, name: @jurisdiction.name } }
    assert_redirected_to jurisdiction_url(@jurisdiction)
  end

  test "should destroy jurisdiction" do
    assert_difference('Jurisdiction.count', -1) do
      delete jurisdiction_url(@jurisdiction)
    end

    assert_redirected_to jurisdictions_url
  end
end
