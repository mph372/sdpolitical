require "application_system_test_case"

class ExpendituresTest < ApplicationSystemTestCase
  setup do
    @expenditure = expenditures(:one)
  end

  test "visiting the index" do
    visit expenditures_url
    assert_selector "h1", text: "Expenditures"
  end

  test "creating a Expenditure" do
    visit expenditures_url
    click_on "New Expenditure"

    fill_in "Amount", with: @expenditure.amount
    fill_in "Description", with: @expenditure.description
    fill_in "Expenditure date", with: @expenditure.expenditure_date
    check "Is amendment" if @expenditure.is_amendment
    check "Is support" if @expenditure.is_support
    fill_in "Measure", with: @expenditure.measure_id
    fill_in "Person", with: @expenditure.person_id
    click_on "Create Expenditure"

    assert_text "Expenditure was successfully created"
    click_on "Back"
  end

  test "updating a Expenditure" do
    visit expenditures_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @expenditure.amount
    fill_in "Description", with: @expenditure.description
    fill_in "Expenditure date", with: @expenditure.expenditure_date
    check "Is amendment" if @expenditure.is_amendment
    check "Is support" if @expenditure.is_support
    fill_in "Measure", with: @expenditure.measure_id
    fill_in "Person", with: @expenditure.person_id
    click_on "Update Expenditure"

    assert_text "Expenditure was successfully updated"
    click_on "Back"
  end

  test "destroying a Expenditure" do
    visit expenditures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expenditure was successfully destroyed"
  end
end
