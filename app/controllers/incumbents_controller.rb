class IncumbentsController < ApplicationController
  before_action :set_incumbent, only: [:show, :edit, :update, :destroy]

  # GET /incumbents
  # GET /incumbents.json
  def index
    @incumbents = Incumbent.all
  end

  # GET /incumbents/1
  # GET /incumbents/1.json
  def show
  end

  # GET /incumbents/new
  def new
    @incumbent = Incumbent.new
  end

  # GET /incumbents/1/edit
  def edit
  end

  # POST /incumbents
  # POST /incumbents.json
  def create
    @incumbent = Incumbent.new(incumbent_params)

    respond_to do |format|
      if @incumbent.save
        format.html { redirect_to @incumbent, notice: 'Incumbent was successfully created.' }
        format.json { render :show, status: :created, location: @incumbent }
      else
        format.html { render :new }
        format.json { render json: @incumbent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incumbents/1
  # PATCH/PUT /incumbents/1.json
  def update
    respond_to do |format|
      if @incumbent.update(incumbent_params)
        format.html { redirect_to @incumbent, notice: 'Incumbent was successfully updated.' }
        format.json { render :show, status: :ok, location: @incumbent }
      else
        format.html { render :edit }
        format.json { render json: @incumbent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incumbents/1
  # DELETE /incumbents/1.json
  def destroy
    @incumbent.destroy
    respond_to do |format|
      format.html { redirect_to incumbents_url, notice: 'Incumbent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_incumbent
      @incumbent = Incumbent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def incumbent_params
      params.require(:incumbent).permit(:title, :first_name, :last_name, :birth_date, :party, :first_elected, :prior_elected, :salary, :professional_career, :congressional_district, :assembly_district, :senate_district, :supe_district, :birth_place, :email, :phone, :term_expires, :term, :twitter, :facebook, :on_ballot, :image, :district_id)
    end
end
