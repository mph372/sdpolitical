require 'test_helper'

class RegistrationSnapshotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration_snapshot = registration_snapshots(:one)
  end

  test "should get index" do
    get registration_snapshots_url
    assert_response :success
  end

  test "should get new" do
    get new_registration_snapshot_url
    assert_response :success
  end

  test "should create registration_snapshot" do
    assert_difference('RegistrationSnapshot.count') do
      post registration_snapshots_url, params: { registration_snapshot: { StatisticalData_id: @registration_snapshot.StatisticalData_id, registered_dem: @registration_snapshot.registered_dem, registered_other: @registration_snapshot.registered_other, registered_rep: @registration_snapshot.registered_rep, snapshot_date: @registration_snapshot.snapshot_date, total_registered: @registration_snapshot.total_registered } }
    end

    assert_redirected_to registration_snapshot_url(RegistrationSnapshot.last)
  end

  test "should show registration_snapshot" do
    get registration_snapshot_url(@registration_snapshot)
    assert_response :success
  end

  test "should get edit" do
    get edit_registration_snapshot_url(@registration_snapshot)
    assert_response :success
  end

  test "should update registration_snapshot" do
    patch registration_snapshot_url(@registration_snapshot), params: { registration_snapshot: { StatisticalData_id: @registration_snapshot.StatisticalData_id, registered_dem: @registration_snapshot.registered_dem, registered_other: @registration_snapshot.registered_other, registered_rep: @registration_snapshot.registered_rep, snapshot_date: @registration_snapshot.snapshot_date, total_registered: @registration_snapshot.total_registered } }
    assert_redirected_to registration_snapshot_url(@registration_snapshot)
  end

  test "should destroy registration_snapshot" do
    assert_difference('RegistrationSnapshot.count', -1) do
      delete registration_snapshot_url(@registration_snapshot)
    end

    assert_redirected_to registration_snapshots_url
  end
end
