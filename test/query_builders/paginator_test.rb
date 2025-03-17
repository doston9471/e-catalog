require "test_helper"

class PaginatorTest < ActiveSupport::TestCase
  test "should initialize with default values" do
    paginator = Paginator.new([])
    assert_equal 1, paginator.page
    assert_equal 10, paginator.per_page
  end

  test "should initialize with custom values" do
    paginator = Paginator.new([], page: 2, per_page: 20)
    assert_equal 2, paginator.page
    assert_equal 20, paginator.per_page
  end

  test "should handle invalid page number" do
    paginator = Paginator.new([], page: 0)
    assert_equal 1, paginator.page
  end

  test "should handle invalid per_page values" do
    paginator = Paginator.new([], per_page: 0)
    assert_equal 10, paginator.per_page

    paginator = Paginator.new([], per_page: 101)
    assert_equal 100, paginator.per_page
  end

  test "should calculate total pages correctly" do
    timestamp = Time.current.to_i
    15.times do |i|
      Brand.create!(name: "Brand #{i} #{timestamp}", description: "Description #{i}")
    end
    paginator = Paginator.new(Brand.all, per_page: 5)
    assert_equal 3, paginator.total_pages
  end

  test "should return 1 page for empty collection" do
    paginator = Paginator.new([], per_page: 10)
    assert_equal 1, paginator.total_pages
  end

  test "should paginate collection correctly" do
    timestamp = Time.current.to_i
    15.times do |i|
      Brand.create!(name: "Brand #{i} #{timestamp}", description: "Description #{i}")
    end
    paginator = Paginator.new(Brand.all, page: 2, per_page: 5)
    result = paginator.paginate
    assert_equal 5, result[:data].size
    assert_equal 3, result[:meta][:total_pages]
    assert_equal 2, result[:meta][:current_page]
    assert_equal 15, result[:meta][:total_count]
    assert_equal 5, result[:meta][:per_page]
  end

  test "should handle last page with remaining items" do
    timestamp = Time.current.to_i
    12.times do |i|
      Brand.create!(name: "Brand #{i} #{timestamp}", description: "Description #{i}")
    end
    paginator = Paginator.new(Brand.all, page: 3, per_page: 5)
    result = paginator.paginate
    assert_equal 2, result[:data].size
    assert_equal 3, result[:meta][:total_pages]
  end

  test "should handle single page result" do
    timestamp = Time.current.to_i
    5.times do |i|
      Brand.create!(name: "Brand #{i} #{timestamp}", description: "Description #{i}")
    end
    paginator = Paginator.new(Brand.all, per_page: 10)
    result = paginator.paginate
    assert_equal 5, result[:data].size
    assert_equal 1, result[:meta][:total_pages]
  end

  test "should handle negative page numbers" do
    paginator = Paginator.new([], page: -1)
    assert_equal 1, paginator.page
  end

  test "should handle string parameters" do
    paginator = Paginator.new([], page: "2", per_page: "20")
    assert_equal 2, paginator.page
    assert_equal 20, paginator.per_page
  end
end
