# app/controllers/election_updates_controller.rb
class ElectionUpdatesController < ApplicationController
    before_action :set_election_update, only: [:show, :edit, :update, :destroy]
    before_action :set_election
    before_action :authorize_admin, except: [:show]

  
    def new
      @election_update = ElectionUpdate.new
    end
  
    def create
        @election_update = @election.election_updates.new(election_update_params)
        logger.debug "ElectionUpdate params: #{election_update_params.inspect}"
        if @election_update.save
          redirect_to @election, notice: 'Election update was successfully created.'
        else
          logger.debug "ElectionUpdate save failed: #{@election_update.errors.full_messages.join(', ')}"
          render :new
        end
    end
      
  
    def edit
    end
  
    def update
      if @election_update.update(election_update_params)
        redirect_to @election_update.election, notice: 'Election update was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @election_update.destroy
      redirect_to elections_url, notice: 'Election update was successfully destroyed.'
    end
  
    private
  
    def set_election_update
      @election_update = ElectionUpdate.find(params[:id])
    end
    
    def set_election
        Rails.logger.debug "Params received: #{params.inspect}"
        @election = Election.friendly.find(params[:election_slug])
      end
      
      
  
    def election_update_params
      params.require(:election_update).permit(:ballots_cast, :mail_ballots, :vote_center_ballots, :registered_voters, :election_id, :ballots_outstanding)
    end
  end
  