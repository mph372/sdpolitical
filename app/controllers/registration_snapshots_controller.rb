class RegistrationSnapshotsController < ApplicationController
  before_action :set_registration_snapshot, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, except: [:show]
  before_action :authenticate_user!
  before_action :admin_mode, except: [:index, :show]

  # GET /registration_snapshots
  # GET /registration_snapshots.json
  def index
    @registration_snapshots = RegistrationSnapshot.all
  end

  # GET /registration_snapshots/1
  # GET /registration_snapshots/1.json
  def show
  end

  # GET /registration_snapshots/new
  def new
    @registration_snapshot = RegistrationSnapshot.new
  end

  # GET /registration_snapshots/1/edit
  def edit
  end

  # POST /registration_snapshots
  # POST /registration_snapshots.json
  def create
    @registration_snapshot = RegistrationSnapshot.new(registration_snapshot_params)

    respond_to do |format|
      if @registration_snapshot.save
        format.html { redirect_to @registration_snapshot, notice: 'Registration snapshot was successfully created.' }
        format.json { render :show, status: :created, location: @registration_snapshot }
      else
        format.html { render :new }
        format.json { render json: @registration_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registration_snapshots/1
  # PATCH/PUT /registration_snapshots/1.json
  def update
    respond_to do |format|
      if @registration_snapshot.update(registration_snapshot_params)
        format.html { redirect_to @registration_snapshot, notice: 'Registration snapshot was successfully updated.' }
        format.json { render :show, status: :ok, location: @registration_snapshot }
      else
        format.html { render :edit }
        format.json { render json: @registration_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registration_snapshots/1
  # DELETE /registration_snapshots/1.json
  def destroy
    @registration_snapshot.destroy
    respond_to do |format|
      format.html { redirect_to registration_snapshots_url, notice: 'Registration snapshot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration_snapshot
      @registration_snapshot = RegistrationSnapshot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registration_snapshot_params
      params.require(:registration_snapshot).permit(:snapshot_date, :total_registered, :registered_dem, :registered_rep, :registered_other, :statistical_datum_id, :district_code)
    end
end
