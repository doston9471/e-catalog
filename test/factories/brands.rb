FactoryBot.define do
  factory :brand do
    name { "Brand #{rand(1000)}" }
    description { "Description" }
  end
end
