class ShopSerializer < BaseSerializer
  def as_json
    {
      id: @object.id.to_s,
      name: @object.name,
      website_url: @object.website_url,
      items: ItemSerializer.serialize_collection(@object.items)
    }
  end
end
