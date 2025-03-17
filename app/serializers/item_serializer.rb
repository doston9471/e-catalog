class ItemSerializer < BaseSerializer
  def as_json
    {
      id: @object.id.to_s,
      shop_id: @object.shop_id.to_s,
      model_id: @object.model_id.to_s,
      characteristics: @object.characteristics,
      prices: @object.prices
    }
  end
end
