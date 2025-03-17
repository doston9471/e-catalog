require "test_helper"

class Api::V1::BrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = create(:brand)
  end

  test "should get index" do
    3.times { create(:brand) }
    get api_v1_brands_url
    assert_response :success
    assert_equal 4, JSON.parse(response.body)["data"].size
  end

  test "should create brand" do
    assert_difference("Brand.count") do
      post api_v1_brands_url,
        params: { brand: { name: "New Brand #{Time.current.to_i}", description: "Description" } },
        as: :json
    end
    assert_response :created
    assert_equal "New Brand", JSON.parse(response.body)["name"].split(" ")[0..1].join(" ")
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
    get api_v1_brand_url(@brand)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal @brand.name, response_body["name"]
    assert_includes response_body.keys, "product_lines"
  end

  test "should update brand" do
    patch api_v1_brand_url(@brand),
      params: { brand: { name: "Updated Name #{Time.current.to_i}" } },
      as: :json
    assert_response :success
    @brand.reload
    assert_equal "Updated Name", @brand.name.split(" ")[0..1].join(" ")
  end

  test "should not update brand with invalid params" do
    patch api_v1_brand_url(@brand),
      params: { brand: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    @brand.reload
    assert_not_equal "", @brand.name
  end

  test "should destroy brand" do
    assert_difference("Brand.count", -1) do
      delete api_v1_brand_url(@brand)
    end
    assert_response :no_content
  end
end
