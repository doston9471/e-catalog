require "test_helper"

class Api::V1::BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Brand.delete_all # Ensure clean state
  end

  test "should get index" do
    create_list(:brand, 3)
    get api_v1_brands_url
    assert_response :success
    assert_equal 3, JSON.parse(response.body).size
  end

  test "should create brand" do
    assert_difference("Brand.count") do
      post api_v1_brands_url,
        params: { brand: { name: "New Brand", description: "Description" } },
        as: :json
    end
    assert_response :created
    assert_equal "New Brand", JSON.parse(response.body)["name"]
  end

  test "should not create brand with invalid params" do
    assert_no_difference("Brand.count") do
      post api_v1_brands_url,
        params: { brand: { name: "" } },
        as: :json
    end
    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert response_body["errors"].present?
    assert response_body["errors"].key?("name")
  end

  test "should show brand" do
    brand = create(:brand)
    get api_v1_brand_url(brand)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal brand.name, response_body["name"]
    assert_includes response_body.keys, "product_lines"
  end

  test "should update brand" do
    brand = create(:brand)
    patch api_v1_brand_url(brand),
      params: { brand: { name: "Updated Name" } },
      as: :json
    assert_response :success
    brand.reload
    assert_equal "Updated Name", brand.name
  end

  test "should not update brand with invalid params" do
    brand = create(:brand)
    patch api_v1_brand_url(brand),
      params: { brand: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    brand.reload
    assert_not_equal "", brand.name
  end

  test "should destroy brand" do
    brand = create(:brand)
    assert_difference("Brand.count", -1) do
      delete api_v1_brand_url(brand)
    end
    assert_response :no_content
  end
end
