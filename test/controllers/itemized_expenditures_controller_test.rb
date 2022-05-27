require 'test_helper'

class ItemizedExpendituresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @itemized_expenditure = itemized_expenditures(:one)
  end

  test "should get index" do
    get itemized_expenditures_url
    assert_response :success
  end

  test "should get new" do
    get new_itemized_expenditure_url
    assert_response :success
  end

  test "should create itemized_expenditure" do
    assert_difference('ItemizedExpenditure.count') do
      post itemized_expenditures_url, params: { itemized_expenditure: { amount: @itemized_expenditure.amount, date: @itemized_expenditure.date, description: @itemized_expenditure.description, expenditure_id: @itemized_expenditure.expenditure_id } }
    end

    assert_redirected_to itemized_expenditure_url(ItemizedExpenditure.last)
  end

  test "should show itemized_expenditure" do
    get itemized_expenditure_url(@itemized_expenditure)
    assert_response :success
  end

  test "should get edit" do
    get edit_itemized_expenditure_url(@itemized_expenditure)
    assert_response :success
  end

  test "should update itemized_expenditure" do
    patch itemized_expenditure_url(@itemized_expenditure), params: { itemized_expenditure: { amount: @itemized_expenditure.amount, date: @itemized_expenditure.date, description: @itemized_expenditure.description, expenditure_id: @itemized_expenditure.expenditure_id } }
    assert_redirected_to itemized_expenditure_url(@itemized_expenditure)
  end

  test "should destroy itemized_expenditure" do
    assert_difference('ItemizedExpenditure.count', -1) do
      delete itemized_expenditure_url(@itemized_expenditure)
    end

    assert_redirected_to itemized_expenditures_url
  end
end
