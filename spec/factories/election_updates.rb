FactoryBot.define do
  factory :election_update do
    association :election
    ballots_cast { 1000 }
    mail_ballots { 600 }
    vote_center_ballots { 400 }
    ballots_outstanding { 500 }
  end
end