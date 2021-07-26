require 'test_helper'

class CampaignFinanceModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign_finance_module = campaign_finance_modules(:one)
  end

  test "should get index" do
    get campaign_finance_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_campaign_finance_module_url
    assert_response :success
  end

  test "should create campaign_finance_module" do
    assert_difference('CampaignFinanceModule.count') do
      post campaign_finance_modules_url, params: { campaign_finance_module: { contribution_limit: @campaign_finance_module.contribution_limit, corporate: @campaign_finance_module.corporate, jurisdiction_id: @campaign_finance_module.jurisdiction_id, jurisdiction_override: @campaign_finance_module.jurisdiction_override, pac: @campaign_finance_module.pac, party: @campaign_finance_module.party, party_limit: @campaign_finance_module.party_limit } }
    end

    assert_redirected_to campaign_finance_module_url(CampaignFinanceModule.last)
  end

  test "should show campaign_finance_module" do
    get campaign_finance_module_url(@campaign_finance_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_campaign_finance_module_url(@campaign_finance_module)
    assert_response :success
  end

  test "should update campaign_finance_module" do
    patch campaign_finance_module_url(@campaign_finance_module), params: { campaign_finance_module: { contribution_limit: @campaign_finance_module.contribution_limit, corporate: @campaign_finance_module.corporate, jurisdiction_id: @campaign_finance_module.jurisdiction_id, jurisdiction_override: @campaign_finance_module.jurisdiction_override, pac: @campaign_finance_module.pac, party: @campaign_finance_module.party, party_limit: @campaign_finance_module.party_limit } }
    assert_redirected_to campaign_finance_module_url(@campaign_finance_module)
  end

  test "should destroy campaign_finance_module" do
    assert_difference('CampaignFinanceModule.count', -1) do
      delete campaign_finance_module_url(@campaign_finance_module)
    end

    assert_redirected_to campaign_finance_modules_url
  end
end
