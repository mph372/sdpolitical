require "application_system_test_case"

class ElectionHistoriesTest < ApplicationSystemTestCase
  setup do
    @election_history = election_histories(:one)
  end

  test "visiting the index" do
    visit election_histories_url
    assert_selector "h1", text: "Election Histories"
  end

  test "creating a Election history" do
    visit election_histories_url
    click_on "New Election History"

    fill_in "Cycle", with: @election_history.cycle
    fill_in "District", with: @election_history.district_id
    fill_in "Election date", with: @election_history.election_date
    fill_in "Election type", with: @election_history.election_type
    fill_in "Number winners", with: @election_history.number_winners
    fill_in "Total votes", with: @election_history.total_votes
    click_on "Create Election history"

    assert_text "Election history was successfully created"
    click_on "Back"
  end

  test "updating a Election history" do
    visit election_histories_url
    click_on "Edit", match: :first

    fill_in "Cycle", with: @election_history.cycle
    fill_in "District", with: @election_history.district_id
    fill_in "Election date", with: @election_history.election_date
    fill_in "Election type", with: @election_history.election_type
    fill_in "Number winners", with: @election_history.number_winners
    fill_in "Total votes", with: @election_history.total_votes
    click_on "Update Election history"

    assert_text "Election history was successfully updated"
    click_on "Back"
  end

  test "destroying a Election history" do
    visit election_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Election history was successfully destroyed"
  end
end
