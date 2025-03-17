require "test_helper"

class BrandSerializerTest < ActiveSupport::TestCase
  setup do
    @brand = create(:brand, name: "Apple", description: "Tech company")
    @product_line = create(:product_line, brand: @brand)
    @serializer = BrandSerializer.new(@brand)
  end

  test "serializes brand attributes" do
    expected = {
      id: @brand.id.to_s,
      name: "Apple",
      description: "Tech company",
      product_lines: [
        {
          id: @product_line.id.to_s,
          name: @product_line.name,
          category: @product_line.category,
          brand_id: @brand.id.to_s,
          models: []
        }
      ]
    }
    assert_equal expected, @serializer.as_json
  end

  test "serializes empty product_lines when none exist" do
    brand = create(:brand, name: "Samsung")
    serializer = BrandSerializer.new(brand)
    assert_equal [], serializer.as_json[:product_lines]
  end
end
