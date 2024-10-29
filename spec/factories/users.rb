FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    confirmed_at { Time.current }
    notify_when_new_report { true }
    first_name { "Test" }
    created_at { Date.new(2024, 1, 1) }
  end
end