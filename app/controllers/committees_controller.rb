class CommitteesController < ApplicationController
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :is_subscriber?
  before_action :authorize_admin, except: [:index, :show]

  # GET /committees
  # GET /committees.json
  def index
    @committees = Committee.all
    set_meta_tags title: 'Committees',
    site: 'The Ballot Book'
  end

  # GET /committees/1
  # GET /committees/1.json
  def show
    @committee = Committee.find(params[:id])
    @reports = @committee.reports
    @expenditures = @committee.expenditures
    set_meta_tags title: @committee.name,
                  site: 'The Ballot Book'
  end

  # GET /committees/new
  def new
    @committee = Committee.new
  end

  # GET /committees/1/edit
  def edit
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)

    respond_to do |format|
      if @committee.save
        format.html { redirect_to @committee, notice: 'Committee was successfully created.' }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to @committee, notice: 'Committee was successfully updated.' }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url, notice: 'Committee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def committee_params
      params.require(:committee).permit(:name, :jurisdiction_id, :committee_type, :person_id, :measure_id, :is_support, :is_active, :is_oppose)
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end
end
