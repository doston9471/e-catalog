class Brand
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  has_many :product_lines, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  index({ name: 1 })
end
