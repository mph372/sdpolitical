require 'test_helper'

class IncumbentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incumbent = incumbents(:one)
  end

  test "should get index" do
    get incumbents_url
    assert_response :success
  end

  test "should get new" do
    get new_incumbent_url
    assert_response :success
  end

  test "should create incumbent" do
    assert_difference('Incumbent.count') do
      post incumbents_url, params: { incumbent: {  } }
    end

    assert_redirected_to incumbent_url(Incumbent.last)
  end

  test "should show incumbent" do
    get incumbent_url(@incumbent)
    assert_response :success
  end

  test "should get edit" do
    get edit_incumbent_url(@incumbent)
    assert_response :success
  end

  test "should update incumbent" do
    patch incumbent_url(@incumbent), params: { incumbent: {  } }
    assert_redirected_to incumbent_url(@incumbent)
  end

  test "should destroy incumbent" do
    assert_difference('Incumbent.count', -1) do
      delete incumbent_url(@incumbent)
    end

    assert_redirected_to incumbents_url
  end
end
