require "application_system_test_case"

class CountyTransactionsTest < ApplicationSystemTestCase
  setup do
    @county_transaction = county_transactions(:one)
  end

  test "visiting the index" do
    visit county_transactions_url
    assert_selector "h1", text: "County Transactions"
  end

  test "creating a County transaction" do
    visit county_transactions_url
    click_on "New County Transaction"

    fill_in "", with: @county_transaction.
    fill_in "Candidate committee", with: @county_transaction.candidate_committee_id
    fill_in "Import", with: @county_transaction.import_id
    fill_in "T.string", with: @county_transaction.t.string
    click_on "Create County transaction"

    assert_text "County transaction was successfully created"
    click_on "Back"
  end

  test "updating a County transaction" do
    visit county_transactions_url
    click_on "Edit", match: :first

    fill_in "", with: @county_transaction.
    fill_in "Candidate committee", with: @county_transaction.candidate_committee_id
    fill_in "Import", with: @county_transaction.import_id
    fill_in "T.string", with: @county_transaction.t.string
    click_on "Update County transaction"

    assert_text "County transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a County transaction" do
    visit county_transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "County transaction was successfully destroyed"
  end
end
