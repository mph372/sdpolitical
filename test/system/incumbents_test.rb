require "application_system_test_case"

class IncumbentsTest < ApplicationSystemTestCase
  setup do
    @incumbent = incumbents(:one)
  end

  test "visiting the index" do
    visit incumbents_url
    assert_selector "h1", text: "Incumbents"
  end

  test "creating a Incumbent" do
    visit incumbents_url
    click_on "New Incumbent"

    click_on "Create Incumbent"

    assert_text "Incumbent was successfully created"
    click_on "Back"
  end

  test "updating a Incumbent" do
    visit incumbents_url
    click_on "Edit", match: :first

    click_on "Update Incumbent"

    assert_text "Incumbent was successfully updated"
    click_on "Back"
  end

  test "destroying a Incumbent" do
    visit incumbents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Incumbent was successfully destroyed"
  end
end
