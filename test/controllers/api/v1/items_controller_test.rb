require "test_helper"

class Api::V1::ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = create(:shop)
    @brand = create(:brand)
    @product_line = create(:product_line, brand: @brand)
    @model = create(:model, product_line: @product_line)
    @item = create(:item, shop: @shop, model: @model)
  end

  test "should get index" do
    3.times { create(:item, shop: @shop, model: @model) }
    get api_v1_items_url
    assert_response :success
    assert_equal 4, JSON.parse(response.body)["data"].size
  end

  test "should create item" do
    assert_difference("Item.count") do
      post api_v1_items_url,
        params: {
          item: {
            shop_id: @shop.id,
            model_id: @model.id,
            characteristics: { "color" => "black" },
            prices: [ { "amount" => 1000, "currency" => "EUR" } ]
          }
        },
        as: :json
    end
    assert_response :created
  end

  test "should not create item with invalid params" do
    assert_no_difference("Item.count") do
      post api_v1_items_url,
        params: { item: { shop_id: nil } },
        as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should show item" do
    get api_v1_item_url(@item)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal @item.shop_id.to_s, response_body["data"]["shop_id"]
    assert_equal @item.model_id.to_s, response_body["data"]["model_id"]
  end

  test "should update item" do
    new_prices = [ { "amount" => 1200, "currency" => "USD" } ]
    new_characteristics = { "color" => "red", "storage" => "256GB" }

    patch api_v1_item_url(@item),
      params: {
        item: {
          characteristics: new_characteristics,
          prices: new_prices
        }
      },
      as: :json

    assert_response :success
    @item.reload
    assert_equal new_characteristics, @item.characteristics
    assert_equal new_prices, @item.prices
  end

  test "should not update item with invalid params" do
    original_prices = @item.prices

    patch api_v1_item_url(@item),
      params: {
        item: {
          prices: []  # Invalid as prices are required
        }
      },
      as: :json

    assert_response :unprocessable_entity
    @item.reload
    assert_equal original_prices, @item.prices
  end

  test "should destroy item" do
    assert_difference("Item.count", -1) do
      delete api_v1_item_url(@item)
    end
    assert_response :no_content
  end
end
