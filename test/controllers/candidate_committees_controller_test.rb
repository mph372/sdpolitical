require 'test_helper'

class CandidateCommitteesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @candidate_committee = candidate_committees(:one)
  end

  test "should get index" do
    get candidate_committees_url
    assert_response :success
  end

  test "should get new" do
    get new_candidate_committee_url
    assert_response :success
  end

  test "should create candidate_committee" do
    assert_difference('CandidateCommittee.count') do
      post candidate_committees_url, params: { candidate_committee: { cycle: @candidate_committee.cycle, name: @candidate_committee.name, references: @candidate_committee.references, status: @candidate_committee.status } }
    end

    assert_redirected_to candidate_committee_url(CandidateCommittee.last)
  end

  test "should show candidate_committee" do
    get candidate_committee_url(@candidate_committee)
    assert_response :success
  end

  test "should get edit" do
    get edit_candidate_committee_url(@candidate_committee)
    assert_response :success
  end

  test "should update candidate_committee" do
    patch candidate_committee_url(@candidate_committee), params: { candidate_committee: { cycle: @candidate_committee.cycle, name: @candidate_committee.name, references: @candidate_committee.references, status: @candidate_committee.status } }
    assert_redirected_to candidate_committee_url(@candidate_committee)
  end

  test "should destroy candidate_committee" do
    assert_difference('CandidateCommittee.count', -1) do
      delete candidate_committee_url(@candidate_committee)
    end

    assert_redirected_to candidate_committees_url
  end
end
