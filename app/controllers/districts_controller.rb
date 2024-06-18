class DistrictsController < ApplicationController
  
  before_action :set_district, only: [:show, :edit, :update, :import, :destroy, :dashboard]
  # before_action :is_subscriber?, except: [:index]
 
  before_action :authorize_admin, except: [:index, :show, :follow, :unfollow]
  before_action :admin_mode, except: [:index, :show, :follow, :unfollow]

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.includes(:jurisdiction, :person).all
    set_meta_tags title: 'Districts',
        site: 'The Ballot Book'
    
  end



  # GET /districts/1
  # GET /districts/1.json
  def show
    @district = District.includes(:person, :statistical_datum).find(params[:id])
  
    if @district.jurisdiction.at_large_districts
      redirect_to @district.jurisdiction
    else
      set_meta_tags title: @district.full_district_name,
                    site: 'The Ballot Book',
                    description: @district.description,
                    keywords: @district.keywords  
  
      @incumbents = @district.person
      @people = Person.all
      @statistical_datum = @district.statistical_datum
  
      respond_to do |format|
        format.html
        format.pdf do
          pdf = Prawn::Document.new
          pdf = DistrictPDF.new(@district)
          send_data pdf.render, filename: "#{@district.jurisdiction.name}_#{@district.name}_#{@district.district}.pdf",
                                type: "application/pdf"
        end
      end
    end
  end
  

  # GET /districts/new
  def new
    @district = District.new
    @district.build_person
    set_meta_tags title: "Create New District",
                  site: 'The Ballot Book'
  end

  # GET /districts/1/edit
  def edit
    @district.build_person if @district.person.nil?
    @person = @district.person
    @district.person_id = @person.id if @person.present?

    set_meta_tags title: "Editing #{@district.full_district_name}",
                  site: 'The Ballot Book'
  end
  
  
  
  

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)
  
    respond_to do |format|
      if assign_person && @district.save
        format.html { redirect_to @district, notice: 'District was successfully created.' }
        format.json { render :show, status: :created, location: @district }
      else
        format.html { render :new }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    assign_person_result = assign_person
  
    respond_to do |format|
      if assign_person_result
        if @district.update(district_params.except(:person_id, :person_attributes))
          format.html { redirect_to @district, notice: 'District was successfully updated.' }
          format.json { render :show, status: :ok, location: @district }
        else
          format.html { render :edit }
          format.json { render json: @district.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  
  
  

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    jurisdiction = @district.jurisdiction
    @district.destroy
    respond_to do |format|
      format.html { redirect_to jurisdiction_path(jurisdiction), notice: 'District was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  


  
  
  
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district
      @district = District.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def district_params
      params.require(:district).permit(
        :id, 
        :name, 
        :district, 
        :jurisdiction_id, 
        :incumbent_id, 
        :at_large_district, 
        :term_expires, 
        :number_of_winners, 
        :is_seat, 
        :is_area, 
        :registration_history_id, 
        :former_office_id, 
        :person_id, 
        :district_title, 
        :archived, 
        :note,
        :district_map,
        person_attributes: [:id, :first_name, :last_name, :image, :remote_image_url, :party, :professional_career, :term, :campaign_website, :bio]
      )
    end
    
    def assign_person
      person_id = district_params[:person_id]
    
      if person_id.present?
        @person = Person.find_by(id: person_id)
    
        if @person
          @person.update(district_id: @district.id, archived: false)
        else
          @district.errors.add(:person_id, "Person with ID=#{person_id} not found")
          return false
        end
      else
        person_attributes = district_params[:person_attributes]
        if person_attributes[:first_name].blank? || person_attributes[:last_name].blank?
          @district.errors.add(:base, "First name and last name can't be blank for new person")
          return false
        end
    
        @district.build_person(person_attributes)
      end
    
      # Unassign the previous person if it's not the current one
      previous_person = Person.where(district_id: @district.id).where.not(id: @person&.id).first
    
      if previous_person
        previous_person.update(district_id: nil, archived: true)
      end
    
      true
    end
    
    
    
    
    

    

end
