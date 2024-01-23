class CandidateCommitteesController < ApplicationController
  before_action :set_candidate_committee, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin

  # GET /candidate_committees
  # GET /candidate_committees.json
  def index
    @candidate_committees = CandidateCommittee.all
  end

  # GET /candidate_committees/1
  # GET /candidate_committees/1.json
  def show
  end

  # GET /candidate_committees/new
  def new
    @candidate_committee = CandidateCommittee.new(person_id: params[:person_id])
  end
  

  # GET /candidate_committees/1/edit
  def edit
  end

  # POST /candidate_committees
  # POST /candidate_committees.json
  def create
    @candidate_committee = CandidateCommittee.new(candidate_committee_params)

    respond_to do |format|
      if @candidate_committee.save
        format.html { redirect_to @candidate_committee, notice: 'Candidate committee was successfully created.' }
        format.json { render :show, status: :created, location: @candidate_committee }
      else
        format.html { render :new }
        format.json { render json: @candidate_committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidate_committees/1
  # PATCH/PUT /candidate_committees/1.json
  def update
    respond_to do |format|
      if @candidate_committee.update(candidate_committee_params)
        format.html { redirect_to @candidate_committee, notice: 'Candidate committee was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate_committee }
      else
        format.html { render :edit }
        format.json { render json: @candidate_committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidate_committees/1
  # DELETE /candidate_committees/1.json
  def destroy
    @candidate_committee.destroy
    respond_to do |format|
      format.html { redirect_to candidate_committees_url, notice: 'Candidate committee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate_committee
      @candidate_committee = CandidateCommittee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def candidate_committee_params
      params.require(:candidate_committee).permit(:person_id, :name, :cycle, :status, :primary_committee)
    end
end
