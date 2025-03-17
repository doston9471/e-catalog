require "test_helper"

class ShopSerializerTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop, name: "iStore", website_url: "https://istore.com")
    @model = create(:model)
    @item = create(:item, shop: @shop, model: @model)
    @serializer = ShopSerializer.new(@shop)
  end

  test "serializes shop attributes" do
    expected = {
      id: @shop.id.to_s,
      name: "iStore",
      website_url: "https://istore.com",
      items: [
        {
          id: @item.id.to_s,
          shop_id: @shop.id.to_s,
          model_id: @model.id.to_s,
          characteristics: @item.characteristics,
          prices: @item.prices
        }
      ]
    }
    assert_equal expected, @serializer.as_json
  end

  test "serializes empty items when none exist" do
    shop = create(:shop)
    serializer = ShopSerializer.new(shop)
    assert_equal [], serializer.as_json[:items]
  end
end
