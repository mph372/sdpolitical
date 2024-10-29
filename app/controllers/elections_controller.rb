class ElectionsController < ApplicationController
  before_action :authorize_admin, except: [:show]
  before_action :set_election, only: [:show, :edit, :update, :process_results_update]

  def new
    @election = Election.new
  end

  def show
    if user_signed_in?
      # Get pinned contests first, maintaining proper includes and order
      @pinned_contests = current_user.pinned_election_contests
                                 .includes(
                                   contestants: :contestant_updates,
                                   election: :election_updates
                                 )
                                 .where(election: @election)
                                 .order('pinned_contests.pin_order')

    @other_contests = @election.contests
                              .includes(
                                contestants: :contestant_updates,
                                election: :election_updates
                              )
                              .where.not(id: @pinned_contests.pluck(:id))
                              .order('created_at ASC')
  
      # Set meta tags
      set_meta_tags title: "#{@election.name} Results",
                  site: 'The Ballot Book',
                  description: "Detailed results and analysis for the #{@election.name} held on #{@election.election_date.strftime("%B %d, %Y")}.",
                  keywords: "San Diego County, #{@election.name}, election results, election analysis",
                  og: {
                    title: @election.name,
                    type: 'website',
                    url: election_url(@election),
                    description: "Explore in-depth results and trends for the #{@election.name}"
                  },
                  twitter: {
                    card: "summary_large_image",
                    site: "@TheBallotBook",
                    title: @election.name,
                    description: "Get the latest updates and detailed analysis of the #{@election.name}",
                  }
    end
  end

  def create
    @election = Election.new(election_params)
    if @election.save
      redirect_to @election, notice: 'Election was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @election.update(election_params)
      redirect_to @election, notice: 'Election was successfully updated.'
    else
      render :edit
    end
  end

  def process_results_update
    logger.debug "Params received: #{params.inspect}"  # Add this line
    ActiveRecord::Base.transaction do
      # Create the election update
      election_update = @election.election_updates.new(
        ballots_cast: params[:ballots_cast],
        mail_ballots: params[:mail_ballots],
        vote_center_ballots: params[:vote_center_ballots],
        registered_voters: params[:registered_voters],
        ballots_outstanding: params[:ballots_outstanding]
      )

      unless election_update.save
        raise ActiveRecord::Rollback, "Failed to save election update"
      end

      # Process the uploaded spreadsheet using the existing uploads controller
      if params[:file].present?
        uploads_controller = UploadsController.new
        uploads_controller.request = request
        uploads_controller.response = response
        uploads_controller.params = ActionController::Parameters.new(
          election_slug: @election.slug,
          vote_type: params[:vote_type],
          file: params[:file]
        )
        
        # Call the create action directly
        uploads_controller.create
        
        # Check if there were any errors during upload
        if uploads_controller.response.status == 302 && 
           uploads_controller.response.location.include?("alert=")
          raise ActiveRecord::Rollback, "Failed to process spreadsheet"
        end
      end

      redirect_to @election, notice: 'Election results were successfully updated.'
    end
  rescue StandardError => e
    redirect_to @election, alert: "Error updating results: #{e.message}"
  end

  private

  def set_election
    @election = Election.friendly.find(params[:slug])  # Changed from params[:id]
  end

  def election_params
    params.require(:election).permit(:name, :election_date)
  end
end