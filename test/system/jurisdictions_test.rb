require "application_system_test_case"

class JurisdictionsTest < ApplicationSystemTestCase
  setup do
    @jurisdiction = jurisdictions(:one)
  end

  test "visiting the index" do
    visit jurisdictions_url
    assert_selector "h1", text: "Jurisdictions"
  end

  test "creating a Jurisdiction" do
    visit jurisdictions_url
    click_on "New Jurisdiction"

    fill_in "Contribution limit", with: @jurisdiction.contribution_limit
    fill_in "Name", with: @jurisdiction.name
    click_on "Create Jurisdiction"

    assert_text "Jurisdiction was successfully created"
    click_on "Back"
  end

  test "updating a Jurisdiction" do
    visit jurisdictions_url
    click_on "Edit", match: :first

    fill_in "Contribution limit", with: @jurisdiction.contribution_limit
    fill_in "Name", with: @jurisdiction.name
    click_on "Update Jurisdiction"

    assert_text "Jurisdiction was successfully updated"
    click_on "Back"
  end

  test "destroying a Jurisdiction" do
    visit jurisdictions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Jurisdiction was successfully destroyed"
  end
end
