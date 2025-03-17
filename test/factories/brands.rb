FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "Brand #{n}" }
    description { "Description" }
  end
end
