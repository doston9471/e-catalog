require "test_helper"

class BrandTest < ActiveSupport::TestCase
  test "should not save brand without name" do
    brand = Brand.new
    assert_not brand.save, "Saved the brand without a name"
  end

  test "should not save duplicate brand names" do
    brand1 = Brand.create(name: "Unique Brand", description: "Description")
    brand2 = Brand.new(name: "Unique Brand")
    assert_not brand2.save, "Saved a brand with a duplicate name"
  end

  test "should have many product_lines" do
    brand = Brand.create(name: "Test Brand")
    product_line = ProductLine.create(name: "Test Line", brand: brand)
    assert_includes brand.product_lines, product_line, "Brand should have associated product lines"
  end
end
