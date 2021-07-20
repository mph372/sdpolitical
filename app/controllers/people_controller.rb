class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :is_subscriber?
  before_action :authorize_admin, except: [:index, :show]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
    @reports = Report.all.order(report_filed: :desc)
    @districts = current_user.following_by_type('District')

    set_meta_tags title: 'Candidates & Elected Officials',
                  site: 'The Ballot Book'
    
    @district_candidates = current_user.following_by_type('District').includes(:person).collect{|u| u.person}.flatten
    @atlarge_candidates = current_user.following_by_type('District').includes(:person).select{|c| c.at_large_district == true}.collect{|u| u.jurisdiction.person}.flatten
    @candidates = @district_candidates + @atlarge_candidates

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf = DashboardPDF.new(@candidates)
        send_data pdf.render, filename: "campaign_finance_report-#{Time.now.strftime('%Y-%m-%d_')}.pdf",
                              type: "application/pdf"
      end
    end
  end


  # GET /people/1
  # GET /people/1.json
  def show
    @former_office = FormerOffice.new
    @person = Person.find(params[:id])
    @reports = @person.reports.order(period_end: :desc)
    @expenditures = @person.expenditures.order(expenditure_date: :desc)

    set_meta_tags title: @person.full_name,
                  site: 'The Ballot Book',
                  description: @person.description,
                  keywords: @person.keywords
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
    assign_district

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
    assign_district
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

  def assign_district
    district_id = person_params[:district_id]
    person_id = @person.id 
    @district = District.find_by(id: district_id)
    if Person.find_by(district_id: district_id).present?
      @old_person = Person.find_by(district_id: district_id)
      @old_person.update_attribute(:archived, true)
      @old_person.update_attribute(:district_id, nil)
    end
    @person.update_attribute(:archived, false)
    @district.update_attribute(:person_id, person_id) unless @district.nil?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_params
      params.require(:person).permit(:title, :first_name, :last_name, :birthdate, :party, :first_elected, :prior_elected, :salary, :professional_career, :congressional_district, :assembly_district, :senate_district, :supe_district, :birthplace, :email, :twitter, :facebook, :phone, :term, :on_ballot, :image, :term_expires, :seeking_office, :official_website, :campaign_website, :is_incumbent, :running_reelection, :incumbent_district, :endorsed_republican, :endorsed_democrat, :ballot_status, :bio, :incumbent_id, :remote_image_url, :incumbent_district_id, :is_appointed, :running_at_large, :incumbent_committee_name, :linkedin_url, :district_id, :campaign_email)
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end
end
