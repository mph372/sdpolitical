class StatisticalDataController < ApplicationController
  before_action :set_statistical_datum, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:show]
  before_action :authenticate_user!
  before_action :admin_mode, except: [:index, :show]

  # GET /statistical_data
  # GET /statistical_data.json
  def index
    @statistical_data = StatisticalDatum.all
  end

  # GET /statistical_data/1
  # GET /statistical_data/1.json
  def show
    @registration_snapshot = RegistrationSnapshot.all.order("snapshot_date desc").limit(1).find_by(statistical_datum_id: @statistical_datum)
  end

  # GET /statistical_data/new
  def new
    @statistical_datum = StatisticalDatum.new
  end

  # GET /statistical_data/1/edit
  def edit
  end

  # POST /statistical_data
  # POST /statistical_data.json
  def create
    @statistical_datum = StatisticalDatum.new(statistical_datum_params)

    respond_to do |format|
      if @statistical_datum.save
        format.html { redirect_to @statistical_datum, notice: 'Statistical datum was successfully created.' }
        format.json { render :show, status: :created, location: @statistical_datum }
      else
        format.html { render :new }
        format.json { render json: @statistical_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistical_data/1
  # PATCH/PUT /statistical_data/1.json
  def update
    respond_to do |format|
      if @statistical_datum.update(statistical_datum_params)
        format.html { redirect_to @statistical_datum, notice: 'Statistical datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @statistical_datum }
      else
        format.html { render :edit }
        format.json { render json: @statistical_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistical_data/1
  # DELETE /statistical_data/1.json
  def destroy
    @statistical_datum.destroy
    respond_to do |format|
      format.html { redirect_to statistical_data_url, notice: 'Statistical datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statistical_datum
      @statistical_datum = StatisticalDatum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def statistical_datum_params
      params.require(:statistical_datum).permit(:district_id,:jurisdiction_id,:district_year,:measure_a_yes,:measure_a_no,:number_of_winners,:registered_2018,:voted_2018,:registered_2016,:voted_2016,:registered_2014,:voted_2014,:registered_2012,:voted_2012,:registered_2020,:voted_2020,:prop_6_yes,:prop_6_no,:prop_51_yes,:prop_51_no,:prop_62_yes,:prop_62_no,:prop_15_yes,:prop_15_no,:prop_16_yes,:prop_16_no,:prop_21_yes,:prop_21_no,:obama_2012,:romney_2012,:trump_2016,:clinton_2016,:trump_2020,:biden_2020,:newsom_2018,:cox_2018,:brown_2014,:kashkari_2014, :district_year)
    end
end
