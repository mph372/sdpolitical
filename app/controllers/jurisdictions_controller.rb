class JurisdictionsController < ApplicationController
  before_action :set_jurisdiction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /jurisdictions
  # GET /jurisdictions.json
  def index
    @jurisdictions = Jurisdiction.all
  end

  # GET /jurisdictions/1
  # GET /jurisdictions/1.json
  def show
    @measures = @jurisdiction.measures
  end

  # GET /jurisdictions/new
  def new
    @jurisdiction = Jurisdiction.new
  end

  # GET /jurisdictions/1/edit
  def edit
  end

  # POST /jurisdictions
  # POST /jurisdictions.json
  def create
    @jurisdiction = Jurisdiction.new(jurisdiction_params)

    respond_to do |format|
      if @jurisdiction.save
        format.html { redirect_to @jurisdiction, notice: 'Jurisdiction was successfully created.' }
        format.json { render :show, status: :created, location: @jurisdiction }
      else
        format.html { render :new }
        format.json { render json: @jurisdiction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jurisdictions/1
  # PATCH/PUT /jurisdictions/1.json
  def update
    respond_to do |format|
      if @jurisdiction.update(jurisdiction_params)
        format.html { redirect_to @jurisdiction, notice: 'Jurisdiction was successfully updated.' }
        format.json { render :show, status: :ok, location: @jurisdiction }
      else
        format.html { render :edit }
        format.json { render json: @jurisdiction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jurisdictions/1
  # DELETE /jurisdictions/1.json
  def destroy
    @jurisdiction.destroy
    respond_to do |format|
      format.html { redirect_to jurisdictions_url, notice: 'Jurisdiction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jurisdiction
      @jurisdiction = Jurisdiction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def jurisdiction_params
      params.require(:jurisdiction).permit(:name, :contribution_limit, :corporate_contributions, :party_contributions, :pac_contributions, :description, :map_url, :jurisdiction_type)
    end
end
