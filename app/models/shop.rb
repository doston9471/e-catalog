class Shop
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :website_url, type: String

  validates :name, presence: true, uniqueness: true
  validates :website_url, presence: true
end
