require 'test_helper'

class RegistrationHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration_history = registration_histories(:one)
  end

  test "should get index" do
    get registration_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_registration_history_url
    assert_response :success
  end

  test "should create registration_history" do
    assert_difference('RegistrationHistory.count') do
      post registration_histories_url, params: { registration_history: { dem_2010: @registration_history.dem_2010, dem_2012: @registration_history.dem_2012, dem_2014: @registration_history.dem_2014, dem_2016: @registration_history.dem_2016, dem_2018: @registration_history.dem_2018, dem_2020: @registration_history.dem_2020, district_id: @registration_history.district_id, gop_2010: @registration_history.gop_2010, gop_2012: @registration_history.gop_2012, gop_2014: @registration_history.gop_2014, gop_2016: @registration_history.gop_2016, gop_2018: @registration_history.gop_2018, gop_2020: @registration_history.gop_2020, jurisdiction_id: @registration_history.jurisdiction_id, total_2010: @registration_history.total_2010, total_2012: @registration_history.total_2012, total_2014: @registration_history.total_2014, total_2016: @registration_history.total_2016, total_2018: @registration_history.total_2018, total_2020: @registration_history.total_2020 } }
    end

    assert_redirected_to registration_history_url(RegistrationHistory.last)
  end

  test "should show registration_history" do
    get registration_history_url(@registration_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_registration_history_url(@registration_history)
    assert_response :success
  end

  test "should update registration_history" do
    patch registration_history_url(@registration_history), params: { registration_history: { dem_2010: @registration_history.dem_2010, dem_2012: @registration_history.dem_2012, dem_2014: @registration_history.dem_2014, dem_2016: @registration_history.dem_2016, dem_2018: @registration_history.dem_2018, dem_2020: @registration_history.dem_2020, district_id: @registration_history.district_id, gop_2010: @registration_history.gop_2010, gop_2012: @registration_history.gop_2012, gop_2014: @registration_history.gop_2014, gop_2016: @registration_history.gop_2016, gop_2018: @registration_history.gop_2018, gop_2020: @registration_history.gop_2020, jurisdiction_id: @registration_history.jurisdiction_id, total_2010: @registration_history.total_2010, total_2012: @registration_history.total_2012, total_2014: @registration_history.total_2014, total_2016: @registration_history.total_2016, total_2018: @registration_history.total_2018, total_2020: @registration_history.total_2020 } }
    assert_redirected_to registration_history_url(@registration_history)
  end

  test "should destroy registration_history" do
    assert_difference('RegistrationHistory.count', -1) do
      delete registration_history_url(@registration_history)
    end

    assert_redirected_to registration_histories_url
  end
end
