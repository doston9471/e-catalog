FactoryBot.define do
  factory :product_line do
    name { "Product Line #{rand(1000)}" }
    category { "Mobile Phones" }
    brand { create(:brand) } # Assumes a Brand factory exists
  end
end
