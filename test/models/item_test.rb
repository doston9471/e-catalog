require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "should not save item without shop_id" do
    item = Item.new(model_id: 1, prices: [ { amount: 1000, currency: "EUR" } ])
    assert_not item.save, "Saved the item without a shop_id"
  end

  test "should not save item without model_id" do
    item = Item.new(shop_id: 1, prices: [ { amount: 1000, currency: "EUR" } ])
    assert_not item.save, "Saved the item without a model_id"
  end

  test "should not save item without prices" do
    item = Item.new(shop_id: 1, model_id: 1)
    assert_not item.save, "Saved the item without prices"
  end

  test "should belong to shop and model" do
    shop = Shop.create(name: "Test Shop", website_url: "http://test.com")
    model = Model.create(name: "Test Model")
    item = Item.create(shop: shop, model: model, prices: [ { amount: 1000, currency: "EUR" } ])
    assert_equal shop, item.shop, "Item should belong to a shop"
    assert_equal model, item.model, "Item should belong to a model"
  end
end
