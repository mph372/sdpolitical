require 'test_helper'

class CitySdTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @city_sd_transaction = city_sd_transactions(:one)
  end

  test "should get index" do
    get city_sd_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_city_sd_transaction_url
    assert_response :success
  end

  test "should create city_sd_transaction" do
    assert_difference('CitySdTransaction.count') do
      post city_sd_transactions_url, params: { city_sd_transaction: { Filer_ID: @city_sd_transaction.Filer_ID, candidate_committee_id: @city_sd_transaction.candidate_committee_id } }
    end

    assert_redirected_to city_sd_transaction_url(CitySdTransaction.last)
  end

  test "should show city_sd_transaction" do
    get city_sd_transaction_url(@city_sd_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_city_sd_transaction_url(@city_sd_transaction)
    assert_response :success
  end

  test "should update city_sd_transaction" do
    patch city_sd_transaction_url(@city_sd_transaction), params: { city_sd_transaction: { Filer_ID: @city_sd_transaction.Filer_ID, candidate_committee_id: @city_sd_transaction.candidate_committee_id } }
    assert_redirected_to city_sd_transaction_url(@city_sd_transaction)
  end

  test "should destroy city_sd_transaction" do
    assert_difference('CitySdTransaction.count', -1) do
      delete city_sd_transaction_url(@city_sd_transaction)
    end

    assert_redirected_to city_sd_transactions_url
  end
end
