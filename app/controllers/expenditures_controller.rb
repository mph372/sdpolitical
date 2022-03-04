class ExpendituresController < ApplicationController
  before_action :set_expenditure, only: [:show, :edit, :update, :destroy]

  before_action :authorize_admin, except: [:index, :show]
  before_action :admin_mode, except: [:index, :show]

  # GET /expenditures
  # GET /expenditures.json
  def index
    @expenditures = Expenditure.all

    set_meta_tags title: 'Expenditures',
    site: 'The Ballot Book'
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
    set_meta_tags title: 'View Expenditure',
        site: 'The Ballot Book'
  end

  # GET /expenditures/new
  def new
    @expenditure = Expenditure.new
  end

  # GET /expenditures/1/edit
  def edit
  end

  # POST /expenditures
  # POST /expenditures.json
  def create
    @expenditure = Expenditure.new(expenditure_params)

    respond_to do |format|
      if @expenditure.save
        if @expenditure.person.present?
          # Create E-Mail Notification
            @expenditure.district_followers.uniq.each do |user|
            if user.notify_when_new_expenditure? && user.subscribed?
              ExpenditureMailer.with(user: user, expenditure: @expenditure).tracked_expenditure.deliver
            end
          end
        end

        format.html { redirect_to @expenditure, notice: 'Expenditure was successfully created.' }
        format.json { render :show, status: :created, location: @expenditure }
      else
        format.html { render :new }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenditures/1
  # PATCH/PUT /expenditures/1.json
  def update
    respond_to do |format|
      if @expenditure.update(expenditure_params)
        format.html { redirect_to @expenditure, notice: 'Expenditure was successfully updated.' }
        format.json { render :show, status: :ok, location: @expenditure }
      else
        format.html { render :edit }
        format.json { render json: @expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.json
  def destroy
    @expenditure.destroy
    respond_to do |format|
      format.html { redirect_to expenditures_url, notice: 'Expenditure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expenditure
      @expenditure = Expenditure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expenditure_params
      params.require(:expenditure).permit(:expenditure_date, :description, :amount, :person_id, :measure_id, :is_support, :is_amendment, :committee_id, :district_id, :election_type, :election_cycle, :is_oppose, :pdf)
    end

    def is_subscriber?
      redirect_to '/pricing', notice: "You must be subscribed to access this page!" unless current_user.subscribed? 
    end
end
