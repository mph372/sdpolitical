require "application_system_test_case"

class DistrictsTest < ApplicationSystemTestCase
  setup do
    @district = districts(:one)
  end

  test "visiting the index" do
    visit districts_url
    assert_selector "h1", text: "Districts"
  end

  test "creating a District" do
    visit districts_url
    click_on "New District"

    fill_in "Average percent", with: @district.average_percent
    fill_in "Brown percent", with: @district.brown_percent
    fill_in "Clinton percent", with: @district.clinton_percent
    fill_in "Cox percent", with: @district.cox_percent
    fill_in "Dem percent", with: @district.dem_percent
    fill_in "District", with: @district.district
    fill_in "Jurisdiction", with: @district.jurisdiction_id
    fill_in "Kashkar percent", with: @district.kashkar_percent
    fill_in "Name", with: @district.name
    fill_in "Newsom percent", with: @district.newsom_percent
    fill_in "Obama percent", with: @district.obama_percent
    fill_in "Other percent", with: @district.other_percent
    fill_in "Rep percent", with: @district.rep_percent
    fill_in "Romney percent", with: @district.romney_percent
    fill_in "Total voters", with: @district.total_voters
    fill_in "Trump percent", with: @district.trump_percent
    click_on "Create District"

    assert_text "District was successfully created"
    click_on "Back"
  end

  test "updating a District" do
    visit districts_url
    click_on "Edit", match: :first

    fill_in "Average percent", with: @district.average_percent
    fill_in "Brown percent", with: @district.brown_percent
    fill_in "Clinton percent", with: @district.clinton_percent
    fill_in "Cox percent", with: @district.cox_percent
    fill_in "Dem percent", with: @district.dem_percent
    fill_in "District", with: @district.district
    fill_in "Jurisdiction", with: @district.jurisdiction_id
    fill_in "Kashkar percent", with: @district.kashkar_percent
    fill_in "Name", with: @district.name
    fill_in "Newsom percent", with: @district.newsom_percent
    fill_in "Obama percent", with: @district.obama_percent
    fill_in "Other percent", with: @district.other_percent
    fill_in "Rep percent", with: @district.rep_percent
    fill_in "Romney percent", with: @district.romney_percent
    fill_in "Total voters", with: @district.total_voters
    fill_in "Trump percent", with: @district.trump_percent
    click_on "Update District"

    assert_text "District was successfully updated"
    click_on "Back"
  end

  test "destroying a District" do
    visit districts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "District was successfully destroyed"
  end
end
