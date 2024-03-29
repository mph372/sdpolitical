class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :is_subscriber?
  before_action :authorize_admin, except: [:index, :show]
  before_action :admin_mode, except: [:index, :show]

  # GET /reports
  # GET /reports.json
  def index
    if params[:person_id]
      @reports = Person.find(params[:person_id]).reports
    else
      @reports = Report.all
    end
    
    set_meta_tags title: 'Campaign Finance Reports',
    site: 'The Ballot Book'
  end



  # GET /reports/1
  # GET /reports/1.json
  def show
    set_meta_tags title: @report.report_name,
    site: 'The Ballot Book'
  end

  # GET /reports/new
  def new
    @report = Report.new

    set_meta_tags title: "New Report",
                site: 'The Ballot Book'
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
    set_meta_tags title: "Edit Report",
                site: 'The Ballot Book'
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        if @report.person.present?
          @report.district_followers.uniq.each do |user|
            if user.notify_when_new_report? && user.subscribed?
              ReportMailer.with(user: user, report: @report).tracked_report.deliver
            end
          end
        end
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @report = Report.find(params[:id])
    @report.update(report_params)
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @candidate_committee = @report.candidate_committee
    @report.destroy
    respond_to do |format|
      format.html { redirect_to candidate_committee_url(@candidate_committee), notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected

  def person
    @person ||=
      if params[:incumbent_id]
        Incumbent.find(params[:incumbent_id])
      elsif params[:candidate_id]
        Candidate.find(params[:candidate_id])
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(
        :period_begin, 
        :period_end, 
        :report_filed, 
        :period_monetary_receipts, 
        :period_nonmonetary_receipts, 
        :period_receipts,
        :period_disbursements, 
        :current_coh, 
        :current_debt, 
        :loans_received, 
        :pdf,
        :is_amended, 
        :candidate_committee_id
      )
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end
end
