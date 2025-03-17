class Model
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :specifications, type: Hash, default: {}
  belongs_to :product_line
  has_many :items, dependent: :destroy

  validates :name, presence: true

  index({ product_line_id: 1 })
end
