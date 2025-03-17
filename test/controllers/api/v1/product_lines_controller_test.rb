require "test_helper"

class Api::V1::ProductLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = create(:brand)
    @product_line = create(:product_line, brand: @brand)
  end

  test "should get index" do
    3.times { create(:product_line, brand: @brand) }
    get api_v1_product_lines_url
    assert_response :success
    assert_equal 4, JSON.parse(response.body)["data"].size
  end

  test "should create product line" do
    assert_difference("ProductLine.count") do
      post api_v1_product_lines_url,
        params: {
          product_line: {
            name: "New Product Line #{Time.current.to_i}",
            category: "Mobile Phones",
            brand_id: @brand.id
          }
        },
        as: :json
    end
    assert_response :created
    assert_equal "New Product Line", JSON.parse(response.body)["name"].split(" ")[0..2].join(" ")
  end

  test "should not create product line with invalid params" do
    assert_no_difference("ProductLine.count") do
      post api_v1_product_lines_url,
        params: { product_line: { name: "" } },
        as: :json
    end
    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert response_body["name"].present?
  end

  test "should show product line" do
    get api_v1_product_line_url(@product_line)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal @product_line.name, response_body["name"]
    assert_includes response_body.keys, "models"
  end

  test "should update product line" do
    patch api_v1_product_line_url(@product_line),
      params: { product_line: { name: "Updated Name #{Time.current.to_i}" } },
      as: :json
    assert_response :success
    @product_line.reload
    assert_equal "Updated Name", @product_line.name.split(" ")[0..1].join(" ")
  end

  test "should not update product line with invalid params" do
    patch api_v1_product_line_url(@product_line),
      params: { product_line: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    @product_line.reload
    assert_not_equal "", @product_line.name
  end

  test "should destroy product line" do
    assert_difference("ProductLine.count", -1) do
      delete api_v1_product_line_url(@product_line)
    end
    assert_response :no_content
  end
end
