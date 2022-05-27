require "application_system_test_case"

class CitySdTransactionsTest < ApplicationSystemTestCase
  setup do
    @city_sd_transaction = city_sd_transactions(:one)
  end

  test "visiting the index" do
    visit city_sd_transactions_url
    assert_selector "h1", text: "City Sd Transactions"
  end

  test "creating a City sd transaction" do
    visit city_sd_transactions_url
    click_on "New City Sd Transaction"

    fill_in "Filer id", with: @city_sd_transaction.Filer_ID
    fill_in "Candidate committee", with: @city_sd_transaction.candidate_committee_id
    click_on "Create City sd transaction"

    assert_text "City sd transaction was successfully created"
    click_on "Back"
  end

  test "updating a City sd transaction" do
    visit city_sd_transactions_url
    click_on "Edit", match: :first

    fill_in "Filer id", with: @city_sd_transaction.Filer_ID
    fill_in "Candidate committee", with: @city_sd_transaction.candidate_committee_id
    click_on "Update City sd transaction"

    assert_text "City sd transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a City sd transaction" do
    visit city_sd_transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "City sd transaction was successfully destroyed"
  end
end
