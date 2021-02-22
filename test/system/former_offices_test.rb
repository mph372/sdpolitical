require "application_system_test_case"

class FormerOfficesTest < ApplicationSystemTestCase
  setup do
    @former_office = former_offices(:one)
  end

  test "visiting the index" do
    visit former_offices_url
    assert_selector "h1", text: "Former Offices"
  end

  test "creating a Former office" do
    visit former_offices_url
    click_on "New Former Office"

    check "Appointed" if @former_office.appointed
    fill_in "District", with: @former_office.district_id
    check "Elected" if @former_office.elected
    fill_in "End year", with: @former_office.end_year
    fill_in "Person", with: @former_office.person_id
    fill_in "Start year", with: @former_office.start_year
    click_on "Create Former office"

    assert_text "Former office was successfully created"
    click_on "Back"
  end

  test "updating a Former office" do
    visit former_offices_url
    click_on "Edit", match: :first

    check "Appointed" if @former_office.appointed
    fill_in "District", with: @former_office.district_id
    check "Elected" if @former_office.elected
    fill_in "End year", with: @former_office.end_year
    fill_in "Person", with: @former_office.person_id
    fill_in "Start year", with: @former_office.start_year
    click_on "Update Former office"

    assert_text "Former office was successfully updated"
    click_on "Back"
  end

  test "destroying a Former office" do
    visit former_offices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Former office was successfully destroyed"
  end
end
