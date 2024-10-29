FactoryBot.define do
  factory :election do
    sequence(:name) { |n| "Election #{n}" }
    election_date { Date.current }
  end
end