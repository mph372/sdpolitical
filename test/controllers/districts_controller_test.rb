require 'test_helper'

class DistrictsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @district = districts(:one)
  end

  test "should get index" do
    get districts_url
    assert_response :success
  end

  test "should get new" do
    get new_district_url
    assert_response :success
  end

  test "should create district" do
    assert_difference('District.count') do
      post districts_url, params: { district: { average_percent: @district.average_percent, brown_percent: @district.brown_percent, clinton_percent: @district.clinton_percent, cox_percent: @district.cox_percent, dem_percent: @district.dem_percent, district: @district.district, jurisdiction_id: @district.jurisdiction_id, kashkar_percent: @district.kashkar_percent, name: @district.name, newsom_percent: @district.newsom_percent, obama_percent: @district.obama_percent, other_percent: @district.other_percent, rep_percent: @district.rep_percent, romney_percent: @district.romney_percent, total_voters: @district.total_voters, trump_percent: @district.trump_percent } }
    end

    assert_redirected_to district_url(District.last)
  end

  test "should show district" do
    get district_url(@district)
    assert_response :success
  end

  test "should get edit" do
    get edit_district_url(@district)
    assert_response :success
  end

  test "should update district" do
    patch district_url(@district), params: { district: { average_percent: @district.average_percent, brown_percent: @district.brown_percent, clinton_percent: @district.clinton_percent, cox_percent: @district.cox_percent, dem_percent: @district.dem_percent, district: @district.district, jurisdiction_id: @district.jurisdiction_id, kashkar_percent: @district.kashkar_percent, name: @district.name, newsom_percent: @district.newsom_percent, obama_percent: @district.obama_percent, other_percent: @district.other_percent, rep_percent: @district.rep_percent, romney_percent: @district.romney_percent, total_voters: @district.total_voters, trump_percent: @district.trump_percent } }
    assert_redirected_to district_url(@district)
  end

  test "should destroy district" do
    assert_difference('District.count', -1) do
      delete district_url(@district)
    end

    assert_redirected_to districts_url
  end
end
