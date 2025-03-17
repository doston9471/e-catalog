class Item
  include Mongoid::Document
  include Mongoid::Timestamps
  field :prices, type: Array, default: []
  field :characteristics, type: Hash, default: {}
  belongs_to :shop
  belongs_to :model

  validates :shop_id, :model_id, presence: true
  validates :prices, presence: true

  index({ shop_id: 1 })
  index({ model_id: 1 })
end
