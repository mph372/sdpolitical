# app/controllers/confirmations_controller.rb
class ConfirmationsController < Devise::ConfirmationsController
    private
  
    def after_confirmation_path_for(resource_name, resource)
      # Find the most recent election
      most_recent_election = Election.where('election_date >= ?', Date.today)
                                   .order(election_date: :asc)
                                   .first || Election.order(election_date: :desc).first
                                   
      election_path(most_recent_election)
    end
  end