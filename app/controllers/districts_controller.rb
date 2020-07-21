class DistrictsController < ApplicationController
  before_action :set_district, only: [:show, :edit, :update, :import, :destroy, :dashboard]
  before_action :authenticate_user!
  before_action :is_subscriber?
  before_action :authorize_admin, except: [:index, :show]

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.all
  end



  # GET /districts/1
  # GET /districts/1.json
  def show
    @district = District.find(params[:id])
    @incumbents = @district.incumbent
    @candidates = @district.candidates
    @people = Person.all

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf = DistrictPDF.new(@district)
        send_data pdf.render, filename: "#{@district.jurisdiction.name}_#{@district.name}_#{@district.district}.pdf",
                              type: "application/pdf",
                              disposition: "inline"

      end
    end
  end

  # GET /districts/new
  def new
    @district = District.new
  end

  # GET /districts/1/edit
  def edit
  end

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)
    
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

  # PATCH/PUT /districts/1
  # PATCH/PUT /districts/1.json
  def update
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

  def follow
    @district = District.find(params[:id])
    current_user.follow(@district)
    flash[:notice] = "You are now following #{@district.jurisdiction.name} - #{@district.name}!"
    redirect_back(fallback_location: dashboard_index_path)
  end

  def unfollow
    @district = District.find(params[:id])
    current_user.stop_following(@district)
    flash[:notice] = "You are no longer following #{@district.jurisdiction.name} - #{@district.name}!"
    redirect_back(fallback_location: dashboard_index_path)
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
# Add and remove districts from/to dashboard for current user
  def dashboard
    type = params[:type]
    if type == "add"
      current_user.dashboard_additions << @district
      redirect_to dashboard_index_path, notice: "#{@district.jurisdiction.name} - #{@district.district} has been added to your dashboard!"
    elsif type == "remove"
      current_user.dashboard_additions.delete(@district)
      redirect_to dashboard_index_path, notice: "#{@district.jurisdiction.name} - #{@district.name} - #{@district.district} has been removed from your dashboard!"
    else
      # type is missing, nothing should happen
      redirect_to district_path(@district), notice: "Looks like nothing happened. Try again."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_district
      @district = District.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def district_params
      params.require(:district).permit(:id, :name, :district, :total_voters, :dem_percent, :rep_percent, :other_percent, :newsom_percent, :cox_percent, :clinton_percent, :trump_percent, :brown_percent, :kashkari_percent, :obama_percent, :romney_percent, :average_percent, :jurisdiction_id, :map_url, :incumbent_id, :contribution_limit, :corporate_contributions, :party_contributions, :pac_contributions, :party_contribution_limit, :term_expires, :measure_a_yes, :measure_a_no, :at_large_district, :number_of_winners, :registered_2018, :registered_2016, :registered_2014, :registered_2012, :voted_2018, :voted_2016, :voted_2014, :voted_2012, :voted_2020, :registered_2020, :prop_6_yes, :prop_6_no, :prop_51_yes, :prop_51_no, :prop_62_yes, :prop_62_no)
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end

end
