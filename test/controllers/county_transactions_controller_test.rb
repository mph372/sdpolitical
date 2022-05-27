require 'test_helper'

class CountyTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @county_transaction = county_transactions(:one)
  end

  test "should get index" do
    get county_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_county_transaction_url
    assert_response :success
  end

  test "should create county_transaction" do
    assert_difference('CountyTransaction.count') do
      post county_transactions_url, params: { county_transaction: { : @county_transaction., candidate_committee_id: @county_transaction.candidate_committee_id, import_id: @county_transaction.import_id, t.string: @county_transaction.t.string } }
    end

    assert_redirected_to county_transaction_url(CountyTransaction.last)
  end

  test "should show county_transaction" do
    get county_transaction_url(@county_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_county_transaction_url(@county_transaction)
    assert_response :success
  end

  test "should update county_transaction" do
    patch county_transaction_url(@county_transaction), params: { county_transaction: { : @county_transaction., candidate_committee_id: @county_transaction.candidate_committee_id, import_id: @county_transaction.import_id, t.string: @county_transaction.t.string } }
    assert_redirected_to county_transaction_url(@county_transaction)
  end

  test "should destroy county_transaction" do
    assert_difference('CountyTransaction.count', -1) do
      delete county_transaction_url(@county_transaction)
    end

    assert_redirected_to county_transactions_url
  end
end
