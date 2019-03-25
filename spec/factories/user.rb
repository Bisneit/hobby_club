FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "first_name #{n}" }
    sequence(:last_name) { |n| "first_name #{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'password'
  end
end
