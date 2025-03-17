FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "Brand #{n} #{Time.current.to_i}" }
    description { "Test Description" }
  end
end
