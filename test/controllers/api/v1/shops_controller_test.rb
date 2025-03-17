require "test_helper"

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Shop.delete_all
  end

  test "should get index" do
    create_list(:shop, 3)
    get api_v1_shops_url
    assert_response :success
    assert_equal 3, JSON.parse(response.body).size
  end

  test "should create shop" do
    assert_difference("Shop.count") do
      post api_v1_shops_url,
        params: { shop: { name: "New Shop", website_url: "http://newshop.com" } },
        as: :json
    end
    assert_response :created
    assert_equal "New Shop", JSON.parse(response.body)["name"]
  end

  test "should not create shop with invalid params" do
    assert_no_difference("Shop.count") do
      post api_v1_shops_url,
        params: { shop: { name: "" } },
        as: :json
    end
    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert response_body["errors"].present?
    assert response_body["errors"].key?("name")
  end

  test "should show shop" do
    shop = create(:shop)
    get api_v1_shop_url(shop)
    assert_response :success
    assert_equal shop.name, JSON.parse(response.body)["name"]
  end

  test "should update shop" do
    shop = create(:shop)
    patch api_v1_shop_url(shop),
      params: { shop: { name: "Updated Name" } },
      as: :json
    assert_response :success
    shop.reload
    assert_equal "Updated Name", shop.name
  end

  test "should not update shop with invalid params" do
    shop = create(:shop)
    patch api_v1_shop_url(shop),
      params: { shop: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    shop.reload
    assert_not_equal "", shop.name
  end

  test "should destroy shop" do
    shop = create(:shop)
    assert_difference("Shop.count", -1) do
      delete api_v1_shop_url(shop)
    end
    assert_response :no_content
  end
end
