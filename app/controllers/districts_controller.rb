class DistrictsController < ApplicationController
  before_action :set_district, only: [:show, :edit, :update, :import, :destroy, :tracker]
  before_action :authenticate_user!
  before_action :is_subscriber?

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

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    @district.destroy
    respond_to do |format|
      format.html { redirect_to districts_url, notice: 'District was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
# Add and remove districts from/to tracker for current user
  def tracker
    type = params[:type]
    if type == "add"
      current_user.tracker_additions << @district
      redirect_to tracker_index_path, notice: "#{@district.name} - #{@district.district} has been added to your tracker!"
    elsif type == "remove"
      current_user.tracker_additions.delete(@district)
      redirect_to root_path, notice: "#{@district.name} - #{@district.district} has been removed from your tracker!"
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
      params.require(:district).permit(:id, :name, :district, :total_voters, :dem_percent, :rep_percent, :other_percent, :newsom_percent, :cox_percent, :clinton_percent, :trump_percent, :brown_percent, :kashkari_percent, :obama_percent, :romney_percent, :average_percent, :jurisdiction_id, :map_url, :incumbent_id, :contribution_limit, :corporate_contributions, :party_contributions, :pac_contributions, :party_contribution_limit)
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end

end
