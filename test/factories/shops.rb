FactoryBot.define do
  factory :shop do
    name { "Shop #{rand(1000)}" }
    website_url { "http://shop#{rand(1000)}.com" }
  end
end
