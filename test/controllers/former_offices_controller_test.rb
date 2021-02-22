require 'test_helper'

class FormerOfficesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @former_office = former_offices(:one)
  end

  test "should get index" do
    get former_offices_url
    assert_response :success
  end

  test "should get new" do
    get new_former_office_url
    assert_response :success
  end

  test "should create former_office" do
    assert_difference('FormerOffice.count') do
      post former_offices_url, params: { former_office: { appointed: @former_office.appointed, district_id: @former_office.district_id, elected: @former_office.elected, end_year: @former_office.end_year, person_id: @former_office.person_id, start_year: @former_office.start_year } }
    end

    assert_redirected_to former_office_url(FormerOffice.last)
  end

  test "should show former_office" do
    get former_office_url(@former_office)
    assert_response :success
  end

  test "should get edit" do
    get edit_former_office_url(@former_office)
    assert_response :success
  end

  test "should update former_office" do
    patch former_office_url(@former_office), params: { former_office: { appointed: @former_office.appointed, district_id: @former_office.district_id, elected: @former_office.elected, end_year: @former_office.end_year, person_id: @former_office.person_id, start_year: @former_office.start_year } }
    assert_redirected_to former_office_url(@former_office)
  end

  test "should destroy former_office" do
    assert_difference('FormerOffice.count', -1) do
      delete former_office_url(@former_office)
    end

    assert_redirected_to former_offices_url
  end
end
