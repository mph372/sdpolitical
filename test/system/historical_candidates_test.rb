require "application_system_test_case"

class HistoricalCandidatesTest < ApplicationSystemTestCase
  setup do
    @historical_candidate = historical_candidates(:one)
  end

  test "visiting the index" do
    visit historical_candidates_url
    assert_selector "h1", text: "Historical Candidates"
  end

  test "creating a Historical candidate" do
    visit historical_candidates_url
    click_on "New Historical Candidate"

    fill_in "Election history", with: @historical_candidate.election_history_id
    fill_in "First name", with: @historical_candidate.first_name
    check "Is winner" if @historical_candidate.is_winner
    fill_in "Last name", with: @historical_candidate.last_name
    fill_in "Votes", with: @historical_candidate.votes
    click_on "Create Historical candidate"

    assert_text "Historical candidate was successfully created"
    click_on "Back"
  end

  test "updating a Historical candidate" do
    visit historical_candidates_url
    click_on "Edit", match: :first

    fill_in "Election history", with: @historical_candidate.election_history_id
    fill_in "First name", with: @historical_candidate.first_name
    check "Is winner" if @historical_candidate.is_winner
    fill_in "Last name", with: @historical_candidate.last_name
    fill_in "Votes", with: @historical_candidate.votes
    click_on "Update Historical candidate"

    assert_text "Historical candidate was successfully updated"
    click_on "Back"
  end

  test "destroying a Historical candidate" do
    visit historical_candidates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Historical candidate was successfully destroyed"
  end
end
