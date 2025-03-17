require "test_helper"

class Api::V1::ProductLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Brand.delete_all
    ProductLine.delete_all
    @brand = create(:brand)
  end

  test "should get index" do
    create_list(:product_line, 3, brand: @brand)
    get api_v1_product_lines_url
    assert_response :success
    assert_equal 3, JSON.parse(response.body).size
  end

  test "should create product_line" do
    assert_difference("ProductLine.count") do
      post api_v1_product_lines_url,
        params: {
          product_line: {
            name: "New Product Line",
            category: "Tablets",
            brand_id: @brand.id
          }
        },
        as: :json
    end
    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "New Product Line", response_body["name"]
    assert_equal "Tablets", response_body["category"]
  end

  test "should not create product_line with invalid params" do
    assert_no_difference("ProductLine.count") do
      post api_v1_product_lines_url,
        params: { product_line: { name: "" } },
        as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should show product_line" do
    product_line = create(:product_line, brand: @brand)
    get api_v1_product_line_url(product_line)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal product_line.name, response_body["name"]
    assert_includes response_body.keys, "models"
  end

  test "should update product_line" do
    product_line = create(:product_line, brand: @brand)
    patch api_v1_product_line_url(product_line),
      params: {
        product_line: {
          name: "Updated Name",
          category: "Laptops"
        }
      },
      as: :json
    assert_response :success
    product_line.reload
    assert_equal "Updated Name", product_line.name
    assert_equal "Laptops", product_line.category
  end

  test "should not update product_line with invalid params" do
    product_line = create(:product_line, brand: @brand)
    patch api_v1_product_line_url(product_line),
      params: { product_line: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    product_line.reload
    assert_not_equal "", product_line.name
  end

  test "should destroy product_line" do
    product_line = create(:product_line, brand: @brand)
    assert_difference("ProductLine.count", -1) do
      delete api_v1_product_line_url(product_line)
    end
    assert_response :no_content
  end
end
