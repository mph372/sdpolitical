require "application_system_test_case"

class RegistrationHistoriesTest < ApplicationSystemTestCase
  setup do
    @registration_history = registration_histories(:one)
  end

  test "visiting the index" do
    visit registration_histories_url
    assert_selector "h1", text: "Registration Histories"
  end

  test "creating a Registration history" do
    visit registration_histories_url
    click_on "New Registration History"

    fill_in "Dem 2010", with: @registration_history.dem_2010
    fill_in "Dem 2012", with: @registration_history.dem_2012
    fill_in "Dem 2014", with: @registration_history.dem_2014
    fill_in "Dem 2016", with: @registration_history.dem_2016
    fill_in "Dem 2018", with: @registration_history.dem_2018
    fill_in "Dem 2020", with: @registration_history.dem_2020
    fill_in "District", with: @registration_history.district_id
    fill_in "Gop 2010", with: @registration_history.gop_2010
    fill_in "Gop 2012", with: @registration_history.gop_2012
    fill_in "Gop 2014", with: @registration_history.gop_2014
    fill_in "Gop 2016", with: @registration_history.gop_2016
    fill_in "Gop 2018", with: @registration_history.gop_2018
    fill_in "Gop 2020", with: @registration_history.gop_2020
    fill_in "Jurisdiction", with: @registration_history.jurisdiction_id
    fill_in "Total 2010", with: @registration_history.total_2010
    fill_in "Total 2012", with: @registration_history.total_2012
    fill_in "Total 2014", with: @registration_history.total_2014
    fill_in "Total 2016", with: @registration_history.total_2016
    fill_in "Total 2018", with: @registration_history.total_2018
    fill_in "Total 2020", with: @registration_history.total_2020
    click_on "Create Registration history"

    assert_text "Registration history was successfully created"
    click_on "Back"
  end

  test "updating a Registration history" do
    visit registration_histories_url
    click_on "Edit", match: :first

    fill_in "Dem 2010", with: @registration_history.dem_2010
    fill_in "Dem 2012", with: @registration_history.dem_2012
    fill_in "Dem 2014", with: @registration_history.dem_2014
    fill_in "Dem 2016", with: @registration_history.dem_2016
    fill_in "Dem 2018", with: @registration_history.dem_2018
    fill_in "Dem 2020", with: @registration_history.dem_2020
    fill_in "District", with: @registration_history.district_id
    fill_in "Gop 2010", with: @registration_history.gop_2010
    fill_in "Gop 2012", with: @registration_history.gop_2012
    fill_in "Gop 2014", with: @registration_history.gop_2014
    fill_in "Gop 2016", with: @registration_history.gop_2016
    fill_in "Gop 2018", with: @registration_history.gop_2018
    fill_in "Gop 2020", with: @registration_history.gop_2020
    fill_in "Jurisdiction", with: @registration_history.jurisdiction_id
    fill_in "Total 2010", with: @registration_history.total_2010
    fill_in "Total 2012", with: @registration_history.total_2012
    fill_in "Total 2014", with: @registration_history.total_2014
    fill_in "Total 2016", with: @registration_history.total_2016
    fill_in "Total 2018", with: @registration_history.total_2018
    fill_in "Total 2020", with: @registration_history.total_2020
    click_on "Update Registration history"

    assert_text "Registration history was successfully updated"
    click_on "Back"
  end

  test "destroying a Registration history" do
    visit registration_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Registration history was successfully destroyed"
  end
end
