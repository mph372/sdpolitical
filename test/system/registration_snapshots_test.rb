require "application_system_test_case"

class RegistrationSnapshotsTest < ApplicationSystemTestCase
  setup do
    @registration_snapshot = registration_snapshots(:one)
  end

  test "visiting the index" do
    visit registration_snapshots_url
    assert_selector "h1", text: "Registration Snapshots"
  end

  test "creating a Registration snapshot" do
    visit registration_snapshots_url
    click_on "New Registration Snapshot"

    fill_in "Statisticaldata", with: @registration_snapshot.StatisticalData_id
    fill_in "Registered dem", with: @registration_snapshot.registered_dem
    fill_in "Registered other", with: @registration_snapshot.registered_other
    fill_in "Registered rep", with: @registration_snapshot.registered_rep
    fill_in "Snapshot date", with: @registration_snapshot.snapshot_date
    fill_in "Total registered", with: @registration_snapshot.total_registered
    click_on "Create Registration snapshot"

    assert_text "Registration snapshot was successfully created"
    click_on "Back"
  end

  test "updating a Registration snapshot" do
    visit registration_snapshots_url
    click_on "Edit", match: :first

    fill_in "Statisticaldata", with: @registration_snapshot.StatisticalData_id
    fill_in "Registered dem", with: @registration_snapshot.registered_dem
    fill_in "Registered other", with: @registration_snapshot.registered_other
    fill_in "Registered rep", with: @registration_snapshot.registered_rep
    fill_in "Snapshot date", with: @registration_snapshot.snapshot_date
    fill_in "Total registered", with: @registration_snapshot.total_registered
    click_on "Update Registration snapshot"

    assert_text "Registration snapshot was successfully updated"
    click_on "Back"
  end

  test "destroying a Registration snapshot" do
    visit registration_snapshots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Registration snapshot was successfully destroyed"
  end
end
