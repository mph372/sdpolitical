class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @reports = Report.all.order(report_filed: :desc)
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
    @reports = @person.reports.order(period_end: :desc)
    @expenditures = @person.expenditures.order(expenditure_date: :desc)
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:district_id, :title, :first_name, :last_name, :birthdate, :party, :first_elected, :prior_elected, :salary, :professional_career, :congressional_district, :assembly_district, :senate_district, :supe_district, :birthplace, :email, :twitter, :facebook, :phone, :term, :on_ballot, :image, :term_expires, :seeking_office, :official_website, :campaign_website, :is_incumbent, :running_reelection, :incumbent_district, :endorsed_republican, :endorsed_democrat, :ballot_status, :bio, :incumbent_id, :remote_image_url, :incumbent_district_id, :is_appointed)
    end
end
