class FormerOfficesController < ApplicationController
  before_action :set_former_office, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_admin, except: [:index, :show]
  before_action :admin_mode, except: [:index, :show]

  # GET /former_offices
  # GET /former_offices.json
  def index
    @former_offices = FormerOffice.all
  end

  # GET /former_offices/1
  # GET /former_offices/1.json
  def show
  end

  # GET /former_offices/new
  def new
    @former_office = FormerOffice.new
    @former_office.build_district
  end

  # GET /former_offices/1/edit
  def edit
  end

  # POST /former_offices
  # POST /former_offices.json
  def create
    @former_office = FormerOffice.new(former_office_params)
     

    respond_to do |format|
      if @former_office.save
        format.html { redirect_to @former_office.person, notice: 'Former office was successfully created.' }
        format.json { render :show, status: :created, location: @former_office }
      else
        format.html { render :new }
        format.json { render json: @former_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /former_offices/1
  # PATCH/PUT /former_offices/1.json
  def update
    respond_to do |format|
      if @former_office.update(former_office_params)
        format.html { redirect_to @former_office.person, notice: 'Former office was successfully updated.' }
        format.json { render :show, status: :ok, location: @former_office }
      else
        format.html { render :edit }
        format.json { render json: @former_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /former_offices/1
  # DELETE /former_offices/1.json
  def destroy
    @former_office.destroy
    respond_to do |format|
      format.html { redirect_to @former_office.person, notice: 'Former office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_former_office
      @former_office = FormerOffice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def former_office_params
      params.require(:former_office).permit(:elected, :appointed, :start_year, :end_year, :person_id, :district_id, :at_large)
    end

end
