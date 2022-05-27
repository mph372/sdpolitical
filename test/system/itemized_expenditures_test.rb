require "application_system_test_case"

class ItemizedExpendituresTest < ApplicationSystemTestCase
  setup do
    @itemized_expenditure = itemized_expenditures(:one)
  end

  test "visiting the index" do
    visit itemized_expenditures_url
    assert_selector "h1", text: "Itemized Expenditures"
  end

  test "creating a Itemized expenditure" do
    visit itemized_expenditures_url
    click_on "New Itemized Expenditure"

    fill_in "Amount", with: @itemized_expenditure.amount
    fill_in "Date", with: @itemized_expenditure.date
    fill_in "Description", with: @itemized_expenditure.description
    fill_in "Expenditure", with: @itemized_expenditure.expenditure_id
    click_on "Create Itemized expenditure"

    assert_text "Itemized expenditure was successfully created"
    click_on "Back"
  end

  test "updating a Itemized expenditure" do
    visit itemized_expenditures_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @itemized_expenditure.amount
    fill_in "Date", with: @itemized_expenditure.date
    fill_in "Description", with: @itemized_expenditure.description
    fill_in "Expenditure", with: @itemized_expenditure.expenditure_id
    click_on "Update Itemized expenditure"

    assert_text "Itemized expenditure was successfully updated"
    click_on "Back"
  end

  test "destroying a Itemized expenditure" do
    visit itemized_expenditures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Itemized expenditure was successfully destroyed"
  end
end
