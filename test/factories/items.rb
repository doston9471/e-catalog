FactoryBot.define do
  factory :item do
    shop { create(:shop) }
    model { create(:model) }
    selected_characteristics { { color: "black", ram_memory: "8gb" } }
    prices { [ { amount: 1000, currency: "EUR" }, { amount: 1200, currency: "USD" } ] }
  end
end
