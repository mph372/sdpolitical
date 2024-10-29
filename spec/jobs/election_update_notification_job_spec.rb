# spec/jobs/election_update_notification_job_spec.rb
require 'rails_helper'

RSpec.describe ElectionUpdateNotificationJob, type: :job do
  include ActiveJob::TestHelper

  let(:election) { create(:election) }
  let(:election_update) { create(:election_update, election: election) }
  
  before do
    ActionMailer::Base.deliveries.clear
    
    @eligible_user = create(:user, 
      email: 'eligible@example.com',
      created_at: Date.new(2024, 1, 1), 
      notify_when_new_report: true,
      confirmed_at: Time.current)
    
    @unconfirmed_user = create(:user,
      email: 'unconfirmed@example.com',
      created_at: Date.new(2024, 1, 1),
      notify_when_new_report: true,
      confirmed_at: nil)
    
    @old_user = create(:user,
      email: 'old@example.com',
      created_at: Date.new(2023, 12, 31),
      notify_when_new_report: true,
      confirmed_at: Time.current)
    
    @opted_out_user = create(:user,
      email: 'opted_out@example.com',
      created_at: Date.new(2024, 1, 1),
      notify_when_new_report: false,
      confirmed_at: Time.current)
  end

  describe '#perform' do
    it 'enqueues email only for eligible users' do
      perform_enqueued_jobs do
        ElectionUpdateNotificationJob.perform_now(election_update.id)
      end

      # Should only deliver to eligible user
      expect(ActionMailer::Base.deliveries.map(&:to).flatten)
        .to contain_exactly(@eligible_user.email)
    end

    it 'does not send emails to unconfirmed users' do
      perform_enqueued_jobs do
        ElectionUpdateNotificationJob.perform_now(election_update.id)
      end
      
      emails_sent = ActionMailer::Base.deliveries.map(&:to).flatten
      expect(emails_sent).not_to include(@unconfirmed_user.email)
    end

    it 'does not send emails to users created before 2024' do
      perform_enqueued_jobs do
        ElectionUpdateNotificationJob.perform_now(election_update.id)
      end
      
      emails_sent = ActionMailer::Base.deliveries.map(&:to).flatten
      expect(emails_sent).not_to include(@old_user.email)
    end

    it 'does not send emails to opted-out users' do
      perform_enqueued_jobs do
        ElectionUpdateNotificationJob.perform_now(election_update.id)
      end
      
      emails_sent = ActionMailer::Base.deliveries.map(&:to).flatten
      expect(emails_sent).not_to include(@opted_out_user.email)
    end
  end
end