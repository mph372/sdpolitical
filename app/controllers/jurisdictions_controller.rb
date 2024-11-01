class JurisdictionsController < ApplicationController
  before_action :set_jurisdiction, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  # before_action :is_subscriber?
  before_action :authorize_admin, except: [:index, :show]
  before_action :admin_mode, except: [:index, :show]

  # GET /jurisdictions
  # GET /jurisdictions.json
  def index
    @jurisdictions = Jurisdiction.all

    set_meta_tags title: 'Jurisdictions',
    site: 'The Ballot Book'

    
  end

  # GET /jurisdictions/1
  # GET /jurisdictions/1.json
  def show

    set_meta_tags title: @jurisdiction.name,
    site: 'The Ballot Book'

    @candidates = @jurisdiction.people.sort_by{|a| [a.district.name, a.district.district]}
    @statistical_datum = @jurisdiction.statistical_datum
    @former_offices = @jurisdiction.former_offices

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf = JurisdictionPDF.new(@jurisdiction)
        send_data pdf.render, filename: "#{@jurisdiction.name}_campaign_finance_report-#{Time.now.strftime('%Y-%m-%d_')}.pdf",
                              type: "application/pdf"
      end
    end
  end

  # GET /jurisdictions/new
  def new
    @jurisdiction = Jurisdiction.new
  end

  def toggle_archive
    @jurisdiction = Jurisdiction.find(params[:id])
    new_archived_status = !@jurisdiction.archived
  
    ActiveRecord::Base.transaction do
      @jurisdiction.update!(archived: new_archived_status)
      @jurisdiction.districts.update_all(archived: new_archived_status)
    end
  
    # Redirect to the homepage
    redirect_to root_path, notice: "Jurisdiction and its districts were successfully updated."
  rescue => e
    # If there's a failure, redirect back to the homepage with an error message
    redirect_to root_path, alert: "Failed to update: #{e.message}"
  end



  # GET /jurisdictions/1/edit
  def edit
  end

  def navigate
    jurisdiction = Jurisdiction.find(params[:jurisdiction_id])
    redirect_to jurisdiction_path(jurisdiction)
  end

  # POST /jurisdictions
  # POST /jurisdictions.json
  def create
    @jurisdiction = Jurisdiction.new(jurisdiction_params)

    respond_to do |format|
      if @jurisdiction.save
        format.html { redirect_to @jurisdiction, notice: 'Jurisdiction was successfully created.' }
        format.json { render :show, status: :created, location: @jurisdiction }
      else
        format.html { render :new }
        format.json { render json: @jurisdiction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jurisdictions/1
  # PATCH/PUT /jurisdictions/1.json
  def update
    respond_to do |format|
      if @jurisdiction.update(jurisdiction_params)
        format.html { redirect_to @jurisdiction, notice: 'Jurisdiction was successfully updated.' }
        format.json { render :show, status: :ok, location: @jurisdiction }
      else
        format.html { render :edit }
        format.json { render json: @jurisdiction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jurisdictions/1
  # DELETE /jurisdictions/1.json
  def destroy
    @jurisdiction.destroy
    respond_to do |format|
      format.html { redirect_to jurisdictions_url, notice: 'Jurisdiction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jurisdiction
      @jurisdiction = Jurisdiction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def jurisdiction_params
      params.require(:jurisdiction).permit(:name, :contribution_limit, :corporate_contributions, :party_contributions, :pac_contributions, :description, :map_url, :jurisdiction_type, :registration_history_id, :at_large_districts, :google_maps_url)
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end
end
