require "application_system_test_case"

class CampaignFinanceModulesTest < ApplicationSystemTestCase
  setup do
    @campaign_finance_module = campaign_finance_modules(:one)
  end

  test "visiting the index" do
    visit campaign_finance_modules_url
    assert_selector "h1", text: "Campaign Finance Modules"
  end

  test "creating a Campaign finance module" do
    visit campaign_finance_modules_url
    click_on "New Campaign Finance Module"

    fill_in "Contribution limit", with: @campaign_finance_module.contribution_limit
    check "Corporate" if @campaign_finance_module.corporate
    fill_in "Jurisdiction", with: @campaign_finance_module.jurisdiction_id
    check "Jurisdiction override" if @campaign_finance_module.jurisdiction_override
    check "Pac" if @campaign_finance_module.pac
    check "Party" if @campaign_finance_module.party
    fill_in "Party limit", with: @campaign_finance_module.party_limit
    click_on "Create Campaign finance module"

    assert_text "Campaign finance module was successfully created"
    click_on "Back"
  end

  test "updating a Campaign finance module" do
    visit campaign_finance_modules_url
    click_on "Edit", match: :first

    fill_in "Contribution limit", with: @campaign_finance_module.contribution_limit
    check "Corporate" if @campaign_finance_module.corporate
    fill_in "Jurisdiction", with: @campaign_finance_module.jurisdiction_id
    check "Jurisdiction override" if @campaign_finance_module.jurisdiction_override
    check "Pac" if @campaign_finance_module.pac
    check "Party" if @campaign_finance_module.party
    fill_in "Party limit", with: @campaign_finance_module.party_limit
    click_on "Update Campaign finance module"

    assert_text "Campaign finance module was successfully updated"
    click_on "Back"
  end

  test "destroying a Campaign finance module" do
    visit campaign_finance_modules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Campaign finance module was successfully destroyed"
  end
end
