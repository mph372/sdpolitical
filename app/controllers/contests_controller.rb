class ContestsController < ApplicationController
  before_action :authorize_admin, except: [:show]

  def show
    @contest = Contest.friendly.find(params[:id])
    @contestants = @contest.contestants.includes(:contestant_updates).order('created_at ASC')

    set_meta_tags title: "#{@contest.name} Detailed Results",
              site: 'The Ballot Book',
              description: "In-depth results and analysis for the #{@contest.name} contest within the #{@election.name} held on #{@contest.election.election_date.strftime("%B %d, %Y")}.",
              keywords: "San Diego County, #{@contest.name}, detailed election results, voting trends",
              og: {
                title: "#{@contest.name} Detailed Results",
                type: 'website',
                url: election_contest_url(@election, @contest),
                description: "Detailed results and trend analysis for the #{@contest.name} contest."
              },
              twitter: {
                card: "summary_large_image",
                site: "@TheBallotBook",  # Replace with your actual Twitter handle
                title: "#{@contest.name} Detailed Results",
                description: "Explore the voting trends and detailed results for the #{@contest.name} contest."
              }
    
  end  
end
