require "test_helper"

class Api::V1::ModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Brand.delete_all
    ProductLine.delete_all
    Model.delete_all
    @brand = create(:brand)
    @product_line = create(:product_line, brand: @brand)
  end

  test "should get index" do
    create_list(:model, 3, product_line: @product_line)
    get api_v1_models_url
    assert_response :success
    assert_equal 3, JSON.parse(response.body).size
  end

  test "should create model" do
    assert_difference("Model.count") do
      post api_v1_models_url,
        params: {
          model: {
            name: "New Model",
            product_line_id: @product_line.id,
            specifications: {
              screen_size: "6.1 inches",
              battery: "4000mAh"
            }
          }
        },
        as: :json
    end
    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "New Model", response_body["name"]
    assert_equal "6.1 inches", response_body["specifications"]["screen_size"]
  end

  test "should not create model with invalid params" do
    assert_no_difference("Model.count") do
      post api_v1_models_url,
        params: { model: { name: "" } },
        as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should show model" do
    model = create(:model, product_line: @product_line)
    get api_v1_model_url(model)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal model.name, response_body["name"]
  end

  test "should update model" do
    model = create(:model, product_line: @product_line)
    patch api_v1_model_url(model),
      params: {
        model: {
          name: "Updated Name",
          specifications: { color: "black" }
        }
      },
      as: :json
    assert_response :success
    model.reload
    assert_equal "Updated Name", model.name
    assert_equal "black", model.specifications["color"]
  end

  test "should not update model with invalid params" do
    model = create(:model, product_line: @product_line)
    patch api_v1_model_url(model),
      params: { model: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    model.reload
    assert_not_equal "", model.name
  end

  test "should destroy model" do
    model = create(:model, product_line: @product_line)
    assert_difference("Model.count", -1) do
      delete api_v1_model_url(model)
    end
    assert_response :no_content
  end
end
