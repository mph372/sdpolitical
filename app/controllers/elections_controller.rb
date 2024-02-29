# app/controllers/elections_controller.rb
class ElectionsController < ApplicationController
    before_action :authorize_admin, except: [:show]

    def new
      @election = Election.new
    end

    def show
      @election = Election.friendly.find(params[:id])
      @contests = @election.contests.includes(:contestants => :contestant_updates).order('created_at ASC')      
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
  