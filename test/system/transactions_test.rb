require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "creating a Transaction" do
    visit transactions_url
    click_on "New Transaction"

    fill_in "Amount", with: @transaction.amount
    fill_in "Candidate committees", with: @transaction.candidate_committees_id
    fill_in "Description", with: @transaction.description
    fill_in "Entity addr1", with: @transaction.entity_addr1
    fill_in "Entity addr2", with: @transaction.entity_addr2
    fill_in "Entity city", with: @transaction.entity_city
    fill_in "Entity employer", with: @transaction.entity_employer
    fill_in "Entity first name", with: @transaction.entity_first_name
    fill_in "Entity last name", with: @transaction.entity_last_name
    fill_in "Entity occupation", with: @transaction.entity_occupation
    fill_in "Entity state", with: @transaction.entity_state
    fill_in "Entity type", with: @transaction.entity_type
    fill_in "Entity zip", with: @transaction.entity_zip
    fill_in "Expense code", with: @transaction.expense_code
    fill_in "Transaction date", with: @transaction.transaction_date
    fill_in "Transaction type", with: @transaction.transaction_type
    fill_in "Uploads", with: @transaction.uploads_id
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "updating a Transaction" do
    visit transactions_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @transaction.amount
    fill_in "Candidate committees", with: @transaction.candidate_committees_id
    fill_in "Description", with: @transaction.description
    fill_in "Entity addr1", with: @transaction.entity_addr1
    fill_in "Entity addr2", with: @transaction.entity_addr2
    fill_in "Entity city", with: @transaction.entity_city
    fill_in "Entity employer", with: @transaction.entity_employer
    fill_in "Entity first name", with: @transaction.entity_first_name
    fill_in "Entity last name", with: @transaction.entity_last_name
    fill_in "Entity occupation", with: @transaction.entity_occupation
    fill_in "Entity state", with: @transaction.entity_state
    fill_in "Entity type", with: @transaction.entity_type
    fill_in "Entity zip", with: @transaction.entity_zip
    fill_in "Expense code", with: @transaction.expense_code
    fill_in "Transaction date", with: @transaction.transaction_date
    fill_in "Transaction type", with: @transaction.transaction_type
    fill_in "Uploads", with: @transaction.uploads_id
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "destroying a Transaction" do
    visit transactions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transaction was successfully destroyed"
  end
end
