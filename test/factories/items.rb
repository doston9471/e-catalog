FactoryBot.define do
  factory :item do
    association :shop
    association :model
    prices { [ { amount: 1000, currency: "EUR" } ] }
    characteristics { { color: "black", storage: "128GB" } }
  end
end
