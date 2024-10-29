# spec/controllers/election_updates_controller_spec.rb
require 'rails_helper'

RSpec.describe ElectionUpdatesController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  let(:election) { create(:election) }
  
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  describe 'POST #create' do
    let(:valid_attributes) do
      {
        ballots_cast: 1000,
        mail_ballots: 600,
        vote_center_ballots: 400,
        ballots_outstanding: 500
      }
    end

    it 'creates a new election update and enqueues notification job' do
      expect {
        post :create, params: { 
          election_slug: election.slug,
          election_update: valid_attributes
        }
      }.to change(ElectionUpdate, :count).by(1)

      expect(ElectionUpdateNotificationJob)
        .to have_been_enqueued
        .with(ElectionUpdate.last.id)
    end

    it 'redirects to the election page after creation' do
      post :create, params: { 
        election_slug: election.slug,
        election_update: valid_attributes
      }
      expect(response).to redirect_to(election)
    end
  end
end