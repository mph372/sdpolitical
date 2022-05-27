require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { amount: @transaction.amount, candidate_committees_id: @transaction.candidate_committees_id, description: @transaction.description, entity_addr1: @transaction.entity_addr1, entity_addr2: @transaction.entity_addr2, entity_city: @transaction.entity_city, entity_employer: @transaction.entity_employer, entity_first_name: @transaction.entity_first_name, entity_last_name: @transaction.entity_last_name, entity_occupation: @transaction.entity_occupation, entity_state: @transaction.entity_state, entity_type: @transaction.entity_type, entity_zip: @transaction.entity_zip, expense_code: @transaction.expense_code, transaction_date: @transaction.transaction_date, transaction_type: @transaction.transaction_type, uploads_id: @transaction.uploads_id } }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { amount: @transaction.amount, candidate_committees_id: @transaction.candidate_committees_id, description: @transaction.description, entity_addr1: @transaction.entity_addr1, entity_addr2: @transaction.entity_addr2, entity_city: @transaction.entity_city, entity_employer: @transaction.entity_employer, entity_first_name: @transaction.entity_first_name, entity_last_name: @transaction.entity_last_name, entity_occupation: @transaction.entity_occupation, entity_state: @transaction.entity_state, entity_type: @transaction.entity_type, entity_zip: @transaction.entity_zip, expense_code: @transaction.expense_code, transaction_date: @transaction.transaction_date, transaction_type: @transaction.transaction_type, uploads_id: @transaction.uploads_id } }
    assert_redirected_to transaction_url(@transaction)
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
