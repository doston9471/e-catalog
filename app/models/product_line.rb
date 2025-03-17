class ProductLine
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :category, type: String, default: "Mobile Phones"
  belongs_to :brand
  has_many :models, dependent: :destroy

  validates :name, presence: true

  index({ brand_id: 1 })
  index({ name: 1 })
  index({ category: 1 })
end
