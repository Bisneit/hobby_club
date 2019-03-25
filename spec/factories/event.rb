FactoryBot.define do
  factory :event do
    sequence(:description) { |n| "description #{n}" }
    sequence(:place) { |n| "place #{n}" }
    date { Date.current }
    start_at { Time.current + 8.hours }
    end_at { Time.current + 10.hours }
  end
end
