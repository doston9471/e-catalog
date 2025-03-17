class Shop
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :website_url, type: String
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :website_url, presence: true

  index({ name: 1 })
end
