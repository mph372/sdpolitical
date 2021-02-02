require 'test_helper'

class HistoricalCandidatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @historical_candidate = historical_candidates(:one)
  end

  test "should get index" do
    get historical_candidates_url
    assert_response :success
  end

  test "should get new" do
    get new_historical_candidate_url
    assert_response :success
  end

  test "should create historical_candidate" do
    assert_difference('HistoricalCandidate.count') do
      post historical_candidates_url, params: { historical_candidate: { election_history_id: @historical_candidate.election_history_id, first_name: @historical_candidate.first_name, is_winner: @historical_candidate.is_winner, last_name: @historical_candidate.last_name, votes: @historical_candidate.votes } }
    end

    assert_redirected_to historical_candidate_url(HistoricalCandidate.last)
  end

  test "should show historical_candidate" do
    get historical_candidate_url(@historical_candidate)
    assert_response :success
  end

  test "should get edit" do
    get edit_historical_candidate_url(@historical_candidate)
    assert_response :success
  end

  test "should update historical_candidate" do
    patch historical_candidate_url(@historical_candidate), params: { historical_candidate: { election_history_id: @historical_candidate.election_history_id, first_name: @historical_candidate.first_name, is_winner: @historical_candidate.is_winner, last_name: @historical_candidate.last_name, votes: @historical_candidate.votes } }
    assert_redirected_to historical_candidate_url(@historical_candidate)
  end

  test "should destroy historical_candidate" do
    assert_difference('HistoricalCandidate.count', -1) do
      delete historical_candidate_url(@historical_candidate)
    end

    assert_redirected_to historical_candidates_url
  end
end
