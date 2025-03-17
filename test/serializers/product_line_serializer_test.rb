require "test_helper"

class ProductLineSerializerTest < ActiveSupport::TestCase
  setup do
    @brand = create(:brand)
    @product_line = create(:product_line, brand: @brand, name: "iPhone", category: "Smartphones")
    @model = create(:model, product_line: @product_line)
    @serializer = ProductLineSerializer.new(@product_line)
  end

  test "serializes product_line attributes" do
    expected = {
      id: @product_line.id.to_s,
      name: "iPhone",
      category: "Smartphones",
      brand_id: @brand.id.to_s,
      models: [
        {
          id: @model.id.to_s,
          name: @model.name,
          description: @model.description,
          product_line_id: @product_line.id.to_s,
          specifications: @model.specifications,
          items: []
        }
      ]
    }
    assert_equal expected, @serializer.as_json
  end

  test "serializes empty models when none exist" do
    product_line = create(:product_line, brand: @brand)
    serializer = ProductLineSerializer.new(product_line)
    assert_equal [], serializer.as_json[:models]
  end
end
