class HistoricalCandidatesController < ApplicationController
  before_action :set_historical_candidate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_admin, except: [:index, :show]

  # GET /historical_candidates
  # GET /historical_candidates.json
  def index
    @historical_candidates = HistoricalCandidate.all.order(votes: :desc).
  end

  # GET /historical_candidates/1
  # GET /historical_candidates/1.json
  def show
  end

  # GET /historical_candidates/new
  def new
    @historical_candidate = HistoricalCandidate.new
  end

  # GET /historical_candidates/1/edit
  def edit
  end

  # POST /historical_candidates
  # POST /historical_candidates.json
  def create
    @historical_candidate = HistoricalCandidate.new(historical_candidate_params)

    respond_to do |format|
      if @historical_candidate.save
        format.html { redirect_to @historical_candidate, notice: 'Historical candidate was successfully created.' }
        format.json { render :show, status: :created, location: @historical_candidate }
      else
        format.html { render :new }
        format.json { render json: @historical_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /historical_candidates/1
  # PATCH/PUT /historical_candidates/1.json
  def update
    respond_to do |format|
      if @historical_candidate.update(historical_candidate_params)
        format.html { redirect_to @historical_candidate, notice: 'Historical candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @historical_candidate }
      else
        format.html { render :edit }
        format.json { render json: @historical_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /historical_candidates/1
  # DELETE /historical_candidates/1.json
  def destroy
    @historical_candidate.destroy
    respond_to do |format|
      format.html { redirect_to historical_candidates_url, notice: 'Historical candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_historical_candidate
      @historical_candidate = HistoricalCandidate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def historical_candidate_params
      params.require(:historical_candidate).permit(:election_history_id, :first_name, :last_name, :votes, :is_winner, :person, :people_id)
    end
  end
end
