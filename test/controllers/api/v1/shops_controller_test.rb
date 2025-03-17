require "test_helper"

class Api::V1::ShopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shop = create(:shop)
  end

  test "should get index" do
    3.times { create(:shop) }
    get api_v1_shops_url
    assert_response :success
    assert_equal 4, JSON.parse(response.body)["data"].size
  end

  test "should create shop" do
    assert_difference("Shop.count") do
      post api_v1_shops_url,
        params: { shop: { name: "New Shop #{Time.current.to_i}", website_url: "http://newshop.com" } },
        as: :json
    end
    assert_response :created
    assert_equal "New Shop", JSON.parse(response.body)["name"].split(" ")[0..1].join(" ")
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
    get api_v1_shop_url(@shop)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal @shop.name, response_body["data"]["name"]
    assert_includes response_body["data"].keys, "items"
  end

  test "should update shop" do
    patch api_v1_shop_url(@shop),
      params: { shop: { name: "Updated Name #{Time.current.to_i}" } },
      as: :json
    assert_response :success
    @shop.reload
    assert_equal "Updated Name", @shop.name.split(" ")[0..1].join(" ")
  end

  test "should not update shop with invalid params" do
    patch api_v1_shop_url(@shop),
      params: { shop: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    @shop.reload
    assert_not_equal "", @shop.name
  end

  test "should destroy shop" do
    assert_difference("Shop.count", -1) do
      delete api_v1_shop_url(@shop)
    end
    assert_response :no_content
  end
end
