class ProductLine
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :category, type: String, default: "Mobile Phones"
  belongs_to :brand

  validates :name, presence: true
end
