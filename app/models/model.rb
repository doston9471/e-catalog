class Model
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :specifications, type: Hash, default: {}
  belongs_to :product_line

  validates :name, presence: true

  index({ product_line_id: 1 })
end
