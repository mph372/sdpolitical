class ElectionsController < ApplicationController
  before_action :authorize_admin, except: [:show]

  def new
    @election = Election.new
  end

  def show
    @election = Election.friendly.find(params[:id])
    
    if user_signed_in?
      @contests = @election.contests.includes(:contestants => :contestant_updates).order('created_at ASC')      

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
                    site: "@TheBallotBook",  # Replace with your actual Twitter handle
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
    @election = Election.find(params[:id])
  end

  def update
    @election = Election.find(params[:id])
    if @election.update(election_params)
      redirect_to @election, notice: 'Election was successfully updated.'
    else
      render :edit
    end
  end

  private

  def election_params
    params.require(:election).permit(:name, :election_date)
  end
end