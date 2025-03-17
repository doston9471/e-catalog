FactoryBot.define do
  factory :product_line do
    sequence(:name) { |n| "Product Line #{n} #{Time.current.to_i}" }
    category { "Mobile Phones" }
    association :brand
  end
end
