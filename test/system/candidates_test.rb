require "application_system_test_case"

class CandidatesTest < ApplicationSystemTestCase
  setup do
    @candidate = candidates(:one)
  end

  test "visiting the index" do
    visit candidates_url
    assert_selector "h1", text: "Candidates"
  end

  test "creating a Candidate" do
    visit candidates_url
    click_on "New Candidate"

    fill_in "Ballot status", with: @candidate.ballot_status
    fill_in "Campaign email", with: @candidate.campaign_email
    fill_in "Campaign facebook", with: @candidate.campaign_facebook
    fill_in "Campaign", with: @candidate.campaign_id
    fill_in "Campaign phone", with: @candidate.campaign_phone
    fill_in "Campaign twitter", with: @candidate.campaign_twitter
    fill_in "Campaign website", with: @candidate.campaign_website
    fill_in "Person", with: @candidate.person_id
    click_on "Create Candidate"

    assert_text "Candidate was successfully created"
    click_on "Back"
  end

  test "updating a Candidate" do
    visit candidates_url
    click_on "Edit", match: :first

    fill_in "Ballot status", with: @candidate.ballot_status
    fill_in "Campaign email", with: @candidate.campaign_email
    fill_in "Campaign facebook", with: @candidate.campaign_facebook
    fill_in "Campaign", with: @candidate.campaign_id
    fill_in "Campaign phone", with: @candidate.campaign_phone
    fill_in "Campaign twitter", with: @candidate.campaign_twitter
    fill_in "Campaign website", with: @candidate.campaign_website
    fill_in "Person", with: @candidate.person_id
    click_on "Update Candidate"

    assert_text "Candidate was successfully updated"
    click_on "Back"
  end

  test "destroying a Candidate" do
    visit candidates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Candidate was successfully destroyed"
  end
end
