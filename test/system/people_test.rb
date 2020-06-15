require "application_system_test_case"

class PeopleTest < ApplicationSystemTestCase
  setup do
    @person = people(:one)
  end

  test "visiting the index" do
    visit people_url
    assert_selector "h1", text: "People"
  end

  test "creating a Person" do
    visit people_url
    click_on "New Person"

    fill_in "Assembly district", with: @person.assembly_district
    fill_in "Birthdate", with: @person.birthdate
    fill_in "Birthplace", with: @person.birthplace
    fill_in "Campaign website", with: @person.campaign_website
    fill_in "Congressional district", with: @person.congressional_district
    fill_in "District", with: @person.district_id
    fill_in "Email", with: @person.email
    fill_in "Facebook", with: @person.facebook
    fill_in "First elected", with: @person.first_elected
    fill_in "First name", with: @person.first_name
    fill_in "Image", with: @person.image
    check "Is incumbent" if @person.is_incumbent
    fill_in "Last name", with: @person.last_name
    fill_in "Official website", with: @person.official_website
    check "On ballot" if @person.on_ballot
    fill_in "Party", with: @person.party
    fill_in "Phone", with: @person.phone
    fill_in "Prior elected", with: @person.prior_elected
    fill_in "Professional career", with: @person.professional_career
    fill_in "Salary", with: @person.salary
    fill_in "Seeking office", with: @person.seeking_office
    fill_in "Senate district", with: @person.senate_district
    fill_in "Supe district", with: @person.supe_district
    fill_in "Term", with: @person.term
    fill_in "Term expires", with: @person.term_expires
    fill_in "Title", with: @person.title
    fill_in "Twitter", with: @person.twitter
    click_on "Create Person"

    assert_text "Person was successfully created"
    click_on "Back"
  end

  test "updating a Person" do
    visit people_url
    click_on "Edit", match: :first

    fill_in "Assembly district", with: @person.assembly_district
    fill_in "Birthdate", with: @person.birthdate
    fill_in "Birthplace", with: @person.birthplace
    fill_in "Campaign website", with: @person.campaign_website
    fill_in "Congressional district", with: @person.congressional_district
    fill_in "District", with: @person.district_id
    fill_in "Email", with: @person.email
    fill_in "Facebook", with: @person.facebook
    fill_in "First elected", with: @person.first_elected
    fill_in "First name", with: @person.first_name
    fill_in "Image", with: @person.image
    check "Is incumbent" if @person.is_incumbent
    fill_in "Last name", with: @person.last_name
    fill_in "Official website", with: @person.official_website
    check "On ballot" if @person.on_ballot
    fill_in "Party", with: @person.party
    fill_in "Phone", with: @person.phone
    fill_in "Prior elected", with: @person.prior_elected
    fill_in "Professional career", with: @person.professional_career
    fill_in "Salary", with: @person.salary
    fill_in "Seeking office", with: @person.seeking_office
    fill_in "Senate district", with: @person.senate_district
    fill_in "Supe district", with: @person.supe_district
    fill_in "Term", with: @person.term
    fill_in "Term expires", with: @person.term_expires
    fill_in "Title", with: @person.title
    fill_in "Twitter", with: @person.twitter
    click_on "Update Person"

    assert_text "Person was successfully updated"
    click_on "Back"
  end

  test "destroying a Person" do
    visit people_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Person was successfully destroyed"
  end
end
