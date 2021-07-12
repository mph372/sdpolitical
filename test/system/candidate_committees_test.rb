require "application_system_test_case"

class CandidateCommitteesTest < ApplicationSystemTestCase
  setup do
    @candidate_committee = candidate_committees(:one)
  end

  test "visiting the index" do
    visit candidate_committees_url
    assert_selector "h1", text: "Candidate Committees"
  end

  test "creating a Candidate committee" do
    visit candidate_committees_url
    click_on "New Candidate Committee"

    fill_in "Cycle", with: @candidate_committee.cycle
    fill_in "Name", with: @candidate_committee.name
    fill_in "References", with: @candidate_committee.references
    fill_in "Status", with: @candidate_committee.status
    click_on "Create Candidate committee"

    assert_text "Candidate committee was successfully created"
    click_on "Back"
  end

  test "updating a Candidate committee" do
    visit candidate_committees_url
    click_on "Edit", match: :first

    fill_in "Cycle", with: @candidate_committee.cycle
    fill_in "Name", with: @candidate_committee.name
    fill_in "References", with: @candidate_committee.references
    fill_in "Status", with: @candidate_committee.status
    click_on "Update Candidate committee"

    assert_text "Candidate committee was successfully updated"
    click_on "Back"
  end

  test "destroying a Candidate committee" do
    visit candidate_committees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Candidate committee was successfully destroyed"
  end
end
