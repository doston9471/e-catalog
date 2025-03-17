require "test_helper"

class ItemSerializerTest < ActiveSupport::TestCase
  setup do
    @shop = create(:shop)
    @model = create(:model)
    @item = create(:item,
                   shop: @shop,
                   model: @model,
                   characteristics: { "color" => "black" },
                   prices: [ { "amount" => 999.99, "currency" => "USD" } ])
    @serializer = ItemSerializer.new(@item)
  end

  test "serializes item attributes" do
    expected = {
      id: @item.id.to_s,
      shop_id: @shop.id.to_s,
      model_id: @model.id.to_s,
      characteristics: { "color" => "black" },
      prices: [ { "amount" => 999.99, "currency" => "USD" } ]
    }
    assert_equal expected, @serializer.as_json
  end
end
