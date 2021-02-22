require "application_system_test_case"

class StatisticalDataTest < ApplicationSystemTestCase
  setup do
    @statistical_datum = statistical_data(:one)
  end

  test "visiting the index" do
    visit statistical_data_url
    assert_selector "h1", text: "Statistical Data"
  end

  test "creating a Statistical datum" do
    visit statistical_data_url
    click_on "New Statistical Datum"

    fill_in "District", with: @statistical_datum.district_id
    fill_in "District year", with: @statistical_datum.district_year
    fill_in "Jurisdiction", with: @statistical_datum.jurisdiction_id
    click_on "Create Statistical datum"

    assert_text "Statistical datum was successfully created"
    click_on "Back"
  end

  test "updating a Statistical datum" do
    visit statistical_data_url
    click_on "Edit", match: :first

    fill_in "District", with: @statistical_datum.district_id
    fill_in "District year", with: @statistical_datum.district_year
    fill_in "Jurisdiction", with: @statistical_datum.jurisdiction_id
    click_on "Update Statistical datum"

    assert_text "Statistical datum was successfully updated"
    click_on "Back"
  end

  test "destroying a Statistical datum" do
    visit statistical_data_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Statistical datum was successfully destroyed"
  end
end
