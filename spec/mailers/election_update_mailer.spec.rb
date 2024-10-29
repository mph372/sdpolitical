require 'rails_helper'

RSpec.describe ElectionUpdateMailer, type: :mailer do
  describe '#new_update_notification' do
    let(:user) { create(:user, first_name: 'Test', email: 'test@example.com', created_at: Date.new(2024, 1, 1)) }
    let(:election) { create(:election, name: 'Primary 2024') }
    let(:election_update) do
      create(:election_update,
             election: election,
             ballots_cast: 1000,
             mail_ballots: 600,
             vote_center_ballots: 400,
             ballots_outstanding: 500)
    end
    let(:mail) { ElectionUpdateMailer.new_update_notification(user, election_update) }

    it 'renders the headers' do
      expect(mail.subject).to eq("New Election Update for Primary 2024")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com']) # Update with your default from address
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(user.first_name)
      expect(mail.body.encoded).to match('1,000') # formatted ballots_cast
      expect(mail.body.encoded).to match('600') # mail_ballots
      expect(mail.body.encoded).to match('400') # vote_center_ballots
      expect(mail.body.encoded).to match('500') # ballots_outstanding
      expect(mail.body.encoded).to match(election_url(election))
    end
  end
end