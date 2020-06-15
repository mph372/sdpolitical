require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post people_url, params: { person: { assembly_district: @person.assembly_district, birthdate: @person.birthdate, birthplace: @person.birthplace, campaign_website: @person.campaign_website, congressional_district: @person.congressional_district, district_id: @person.district_id, email: @person.email, facebook: @person.facebook, first_elected: @person.first_elected, first_name: @person.first_name, image: @person.image, is_incumbent: @person.is_incumbent, last_name: @person.last_name, official_website: @person.official_website, on_ballot: @person.on_ballot, party: @person.party, phone: @person.phone, prior_elected: @person.prior_elected, professional_career: @person.professional_career, salary: @person.salary, seeking_office: @person.seeking_office, senate_district: @person.senate_district, supe_district: @person.supe_district, term: @person.term, term_expires: @person.term_expires, title: @person.title, twitter: @person.twitter } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { assembly_district: @person.assembly_district, birthdate: @person.birthdate, birthplace: @person.birthplace, campaign_website: @person.campaign_website, congressional_district: @person.congressional_district, district_id: @person.district_id, email: @person.email, facebook: @person.facebook, first_elected: @person.first_elected, first_name: @person.first_name, image: @person.image, is_incumbent: @person.is_incumbent, last_name: @person.last_name, official_website: @person.official_website, on_ballot: @person.on_ballot, party: @person.party, phone: @person.phone, prior_elected: @person.prior_elected, professional_career: @person.professional_career, salary: @person.salary, seeking_office: @person.seeking_office, senate_district: @person.senate_district, supe_district: @person.supe_district, term: @person.term, term_expires: @person.term_expires, title: @person.title, twitter: @person.twitter } }
    assert_redirected_to person_url(@person)
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end
end
