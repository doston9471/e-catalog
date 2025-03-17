require "test_helper"

class ProductLineTest < ActiveSupport::TestCase
  test "should not save product_line without name" do
    product_line = ProductLine.new
    assert_not product_line.save, "Saved the product_line without a name"
  end

  test "should not save product_line without brand" do
    product_line = ProductLine.new(name: "Test Line")
    assert_not product_line.save, "Saved the product_line without a brand"
  end

  test "should belong to brand" do
    brand = create(:brand)
    product_line = ProductLine.create(name: "Test Line", brand: brand)
    assert_equal brand, product_line.brand, "ProductLine should belong to a brand"
  end

  test "should have many models" do
    product_line = create(:product_line)
    model = create(:model, product_line: product_line)
    assert_includes product_line.models, model, "ProductLine should have associated models"
  end
end
