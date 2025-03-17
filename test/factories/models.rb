FactoryBot.define do
  factory :model do
    name { "Model #{rand(1000)}" }
    # Add product_line association if required
  end
end
