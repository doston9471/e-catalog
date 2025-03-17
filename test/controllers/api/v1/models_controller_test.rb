require "test_helper"

class Api::V1::ModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand = create(:brand)
    @product_line = create(:product_line, brand: @brand)
    @model = create(:model, product_line: @product_line)
    @shop = create(:shop)
    create(:item, model: @model, shop: @shop)
  end

  test "should get index" do
    3.times { create(:model, product_line: @product_line) }
    get api_v1_models_url
    assert_response :success
    assert_equal 4, JSON.parse(response.body)["data"].size
  end

  test "should create model" do
    assert_difference("Model.count") do
      post api_v1_models_url,
        params: {
          model: {
            name: "New Model #{Time.current.to_i}",
            description: "Description",
            product_line_id: @product_line.id,
            specifications: {}
          }
        },
        as: :json
    end
    assert_response :created
    assert_equal "New Model", JSON.parse(response.body)["name"].split(" ")[0..1].join(" ")
  end

  test "should not create model with invalid params" do
    assert_no_difference("Model.count") do
      post api_v1_models_url,
        params: { model: { name: "" } },
        as: :json
    end
    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert response_body["errors"].present?
    assert response_body["errors"].key?("name")
  end

  test "should show model" do
    get api_v1_model_url(@model)
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal @model.name, response_body["data"]["name"]
    assert_includes response_body["data"].keys, "items"
    assert response_body["data"]["items"].is_a?(Array)
    assert_equal 1, response_body["data"]["items"].size
  end

  test "should update model" do
    patch api_v1_model_url(@model),
      params: { model: { name: "Updated Name #{Time.current.to_i}" } },
      as: :json
    assert_response :success
    @model.reload
    assert_equal "Updated Name", @model.name.split(" ")[0..1].join(" ")
  end

  test "should not update model with invalid params" do
    patch api_v1_model_url(@model),
      params: { model: { name: "" } },
      as: :json
    assert_response :unprocessable_entity
    @model.reload
    assert_not_equal "", @model.name
  end

  test "should destroy model" do
    assert_difference("Model.count", -1) do
      delete api_v1_model_url(@model)
    end
    assert_response :no_content
  end
end
