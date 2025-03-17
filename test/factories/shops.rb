FactoryBot.define do
  factory :shop do
    sequence(:name) { |n| "Shop #{n} #{Time.current.to_i}" }
    website_url { "http://test.com" }
  end
end
