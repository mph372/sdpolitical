class CampaignFinanceModulesController < ApplicationController
  before_action :set_campaign_finance_module, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin
  before_action :admin_mode

  # GET /campaign_finance_modules
  # GET /campaign_finance_modules.json
  def index
    @campaign_finance_modules = CampaignFinanceModule.all
  end

  # GET /campaign_finance_modules/1
  # GET /campaign_finance_modules/1.json
  def show
  end

  # GET /campaign_finance_modules/new
  def new
    @campaign_finance_module = CampaignFinanceModule.new
  end

  # GET /campaign_finance_modules/1/edit
  def edit
  end

  # POST /campaign_finance_modules
  # POST /campaign_finance_modules.json
  def create
    @campaign_finance_module = CampaignFinanceModule.new(campaign_finance_module_params)

    respond_to do |format|
      if @campaign_finance_module.save
        format.html { redirect_to @campaign_finance_module, notice: 'Campaign finance module was successfully created.' }
        format.json { render :show, status: :created, location: @campaign_finance_module }
      else
        format.html { render :new }
        format.json { render json: @campaign_finance_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaign_finance_modules/1
  # PATCH/PUT /campaign_finance_modules/1.json
  def update
    respond_to do |format|
      if @campaign_finance_module.update(campaign_finance_module_params)
        format.html { redirect_to @campaign_finance_module, notice: 'Campaign finance module was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign_finance_module }
      else
        format.html { render :edit }
        format.json { render json: @campaign_finance_module.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_finance_modules/1
  # DELETE /campaign_finance_modules/1.json
  def destroy
    @campaign_finance_module.destroy
    respond_to do |format|
      format.html { redirect_to campaign_finance_modules_url, notice: 'Campaign finance module was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_finance_module
      @campaign_finance_module = CampaignFinanceModule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_finance_module_params
      params.require(:campaign_finance_module).permit(:corporate, :pac, :party, :contribution_limit, :party_limit, :district_id, :jurisdiction_id)
    end
end
