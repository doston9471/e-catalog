FactoryBot.define do
  factory :product_line do
    sequence(:name) { |n| "Product Line #{n}" }
    category { "Mobile Phones" }
    brand { create(:brand) } # Assumes a Brand factory exists
  end
end
