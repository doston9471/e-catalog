FactoryBot.define do
  factory :model do
    sequence(:name) { |n| "Model #{n} #{Time.current.to_i}" }
    description { "Test Description" }
    specifications { {} }
    association :product_line
  end
end
