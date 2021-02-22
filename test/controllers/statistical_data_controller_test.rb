require 'test_helper'

class StatisticalDataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @statistical_datum = statistical_data(:one)
  end

  test "should get index" do
    get statistical_data_url
    assert_response :success
  end

  test "should get new" do
    get new_statistical_datum_url
    assert_response :success
  end

  test "should create statistical_datum" do
    assert_difference('StatisticalDatum.count') do
      post statistical_data_url, params: { statistical_datum: { district_id: @statistical_datum.district_id, district_year: @statistical_datum.district_year, jurisdiction_id: @statistical_datum.jurisdiction_id } }
    end

    assert_redirected_to statistical_datum_url(StatisticalDatum.last)
  end

  test "should show statistical_datum" do
    get statistical_datum_url(@statistical_datum)
    assert_response :success
  end

  test "should get edit" do
    get edit_statistical_datum_url(@statistical_datum)
    assert_response :success
  end

  test "should update statistical_datum" do
    patch statistical_datum_url(@statistical_datum), params: { statistical_datum: { district_id: @statistical_datum.district_id, district_year: @statistical_datum.district_year, jurisdiction_id: @statistical_datum.jurisdiction_id } }
    assert_redirected_to statistical_datum_url(@statistical_datum)
  end

  test "should destroy statistical_datum" do
    assert_difference('StatisticalDatum.count', -1) do
      delete statistical_datum_url(@statistical_datum)
    end

    assert_redirected_to statistical_data_url
  end
end
