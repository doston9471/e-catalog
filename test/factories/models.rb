FactoryBot.define do
  factory :model do
    sequence(:name) { |n| "Model #{n}" }
    product_line { create(:product_line) }
  end
end
