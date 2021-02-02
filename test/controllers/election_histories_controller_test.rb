require 'test_helper'

class ElectionHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @election_history = election_histories(:one)
  end

  test "should get index" do
    get election_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_election_history_url
    assert_response :success
  end

  test "should create election_history" do
    assert_difference('ElectionHistory.count') do
      post election_histories_url, params: { election_history: { cycle: @election_history.cycle, district_id: @election_history.district_id, election_date: @election_history.election_date, election_type: @election_history.election_type, number_winners: @election_history.number_winners, total_votes: @election_history.total_votes } }
    end

    assert_redirected_to election_history_url(ElectionHistory.last)
  end

  test "should show election_history" do
    get election_history_url(@election_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_election_history_url(@election_history)
    assert_response :success
  end

  test "should update election_history" do
    patch election_history_url(@election_history), params: { election_history: { cycle: @election_history.cycle, district_id: @election_history.district_id, election_date: @election_history.election_date, election_type: @election_history.election_type, number_winners: @election_history.number_winners, total_votes: @election_history.total_votes } }
    assert_redirected_to election_history_url(@election_history)
  end

  test "should destroy election_history" do
    assert_difference('ElectionHistory.count', -1) do
      delete election_history_url(@election_history)
    end

    assert_redirected_to election_histories_url
  end
end
