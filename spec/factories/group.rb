FactoryBot.define do
  factory :group do
    sequence(:name) { |n| "name #{n}" }
  end
end
