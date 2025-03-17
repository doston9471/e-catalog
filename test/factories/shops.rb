FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "Shop #{n}" }
    website_url { "http://shop#{rand(1000)}.com" }
  end
end
