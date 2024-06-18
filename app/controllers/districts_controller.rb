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
      redirect_to @district.jurisdiction, notice: 'This district is part of an at-large jurisdiction.'
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
    set_meta_tags title: "Create New District",
                  site: 'The Ballot Book'
  end

  # GET /districts/1/edit
  def edit
    set_meta_tags title: "Editing #{@district.full_district_name}",
                  site: 'The Ballot Book'
  end  

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)
    assign_person

    respond_to do |format|
      if @district.save
        format.html { redirect_to @district, notice: 'District was successfully created.' }
        format.json { render :show, status: :created, location: @district }
      else
        format.html { render :new }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    assign_person

    respond_to do |format|
      if @district.update(district_params)
        format.html { redirect_to @district, notice: 'District was successfully updated.' }
        format.json { render :show, status: :ok, location: @district }
      else
        format.html { render :edit }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    @district.destroy
    respond_to do |format|
      format.html { redirect_to districts_url, notice: 'District was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def assign_person
    person_id = district_params[:person_id]
    @person = Person.find_by(id: person_id)

    if @person
      @person.update(district_id: @district.id, archived: false)
    end

    # Unassign the previous person if it's not the current one
    previous_person = Person.find_by(district_id: @district.id)
    if previous_person && previous_person != @person
      previous_person.update(district_id: nil, archived: true)
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
        :district_map
      )
    end
    

    

end
