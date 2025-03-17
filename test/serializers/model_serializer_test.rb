require "test_helper"

class ModelSerializerTest < ActiveSupport::TestCase
  setup do
    @product_line = create(:product_line)
    @model = create(:model, product_line: @product_line, name: "iPhone 16", specifications: { "color" => [ "black" ] })
    @shop = create(:shop)
    @item = create(:item, model: @model, shop: @shop)
    @serializer = ModelSerializer.new(@model)
  end

  test "serializes model attributes" do
    expected = {
      id: @model.id.to_s,
      name: "iPhone 16",
      description: "Test Description",
      product_line_id: @product_line.id.to_s,
      specifications: { "color" => [ "black" ] },
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
    model = create(:model, product_line: @product_line)
    serializer = ModelSerializer.new(model)
    assert_equal [], serializer.as_json[:items]
  end
end
