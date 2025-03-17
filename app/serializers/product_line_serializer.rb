class ProductLineSerializer < BaseSerializer
  def as_json
    {
      id: @object.id.to_s,
      name: @object.name,
      category: @object.category,
      brand_id: @object.brand_id.to_s,
      models: ModelSerializer.serialize_collection(@object.models)
    }
  end
end
