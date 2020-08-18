class RegistrationHistoriesController < ApplicationController
  before_action :set_registration_history, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?

  # GET /registration_histories
  # GET /registration_histories.json
  def index
    @registration_histories = RegistrationHistory.all
  end

  # GET /registration_histories/1
  # GET /registration_histories/1.json
  def show
  end

  # GET /registration_histories/new
  def new
    @registration_history = RegistrationHistory.new
  end

  # GET /registration_histories/1/edit
  def edit
  end

  # POST /registration_histories
  # POST /registration_histories.json
  def create
    @registration_history = RegistrationHistory.new(registration_history_params)

    respond_to do |format|
      if @registration_history.save
        format.html { redirect_to @registration_history, notice: 'Registration history was successfully created.' }
        format.json { render :show, status: :created, location: @registration_history }
      else
        format.html { render :new }
        format.json { render json: @registration_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registration_histories/1
  # PATCH/PUT /registration_histories/1.json
  def update
    respond_to do |format|
      if @registration_history.update(registration_history_params)
        format.html { redirect_to @registration_history, notice: 'Registration history was successfully updated.' }
        format.json { render :show, status: :ok, location: @registration_history }
      else
        format.html { render :edit }
        format.json { render json: @registration_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registration_histories/1
  # DELETE /registration_histories/1.json
  def destroy
    @registration_history.destroy
    respond_to do |format|
      format.html { redirect_to registration_histories_url, notice: 'Registration history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration_history
      @registration_history = RegistrationHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registration_history_params
      params.require(:registration_history).permit( :total_2012, :total_2014, :total_2016, :total_2018, :total_2020, :gop_2012, :gop_2014, :gop_2016, :gop_2018, :gop_2020, :dem_2012, :dem_2014, :dem_2016, :dem_2018, :dem_2020, :district_id, :jurisdiction_id, :name)
    end

    def is_admin?
      redirect_to '/pricing', notice: "You do not have access this page!" unless current_user.admin? 
    end
end
