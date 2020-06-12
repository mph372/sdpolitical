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

    fill_in "Birth date", with: @candidate.birth_date
    fill_in "Campaign website", with: @candidate.campaign_website
    fill_in "District", with: @candidate.district_id
    fill_in "Email", with: @candidate.email
    fill_in "Facebook", with: @candidate.facebook
    fill_in "Party", with: @candidate.party
    fill_in "Professional career", with: @candidate.professional_career
    fill_in "Twitter", with: @candidate.twitter
    click_on "Create Candidate"

    assert_text "Candidate was successfully created"
    click_on "Back"
  end

  test "updating a Candidate" do
    visit candidates_url
    click_on "Edit", match: :first

    fill_in "Birth date", with: @candidate.birth_date
    fill_in "Campaign website", with: @candidate.campaign_website
    fill_in "District", with: @candidate.district_id
    fill_in "Email", with: @candidate.email
    fill_in "Facebook", with: @candidate.facebook
    fill_in "Party", with: @candidate.party
    fill_in "Professional career", with: @candidate.professional_career
    fill_in "Twitter", with: @candidate.twitter
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
