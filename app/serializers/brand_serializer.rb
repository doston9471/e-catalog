class BrandSerializer < BaseSerializer
  def as_json
    {
      id: @object.id.to_s,
      name: @object.name,
      description: @object.description,
      product_lines: ProductLineSerializer.serialize_collection(@object.product_lines)
    }
  end
end
