class ElectionHistoriesController < ApplicationController
  before_action :set_election_history, only: [:show, :edit, :update, :destroy]

  # GET /election_histories
  # GET /election_histories.json
  def index
    @election_histories = ElectionHistory.all
  end

  # GET /election_histories/1
  # GET /election_histories/1.json
  def show
  end

  # GET /election_histories/new
  def new
    @election_history = ElectionHistory.new
    @election_history.historical_candidates.build
  end

  # GET /election_histories/1/edit
  def edit
    @election_history.historical_candidates.build
  end

  # POST /election_histories
  # POST /election_histories.json
  def create
    @election_history = ElectionHistory.new(election_history_params)

    respond_to do |format|
      if @election_history.save
        format.html { redirect_to @election_history, notice: 'Election history was successfully created.' }
        format.json { render :show, status: :created, location: @election_history }
      else
        format.html { render :new }
        format.json { render json: @election_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /election_histories/1
  # PATCH/PUT /election_histories/1.json
  def update
    respond_to do |format|
      if @election_history.update(election_history_params)
        format.html { redirect_to @election_history, notice: 'Election history was successfully updated.' }
        format.json { render :show, status: :ok, location: @election_history }
      else
        format.html { render :edit }
        format.json { render json: @election_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /election_histories/1
  # DELETE /election_histories/1.json
  def destroy
    @election_history.destroy
    respond_to do |format|
      format.html { redirect_to election_histories_url, notice: 'Election history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_election_history
      @election_history = ElectionHistory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def election_history_params
      params.require(:election_history).permit(:cycle, :election_type, :election_date, :number_winners, :total_votes, :district_id, historical_candidates_attributes: [:election_history_id, :first_name, :last_name, :votes, :is_winner, :created_at, :update_birthdate_fields, :person_id, :person])
    end
end
