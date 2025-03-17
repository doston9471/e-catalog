class ModelSerializer < BaseSerializer
  def as_json
    {
      id: @object.id.to_s,
      name: @object.name,
      description: @object.description,
      product_line_id: @object.product_line_id.to_s,
      specifications: @object.specifications,
      items: ItemSerializer.serialize_collection(@object.items)
    }
  end
end
