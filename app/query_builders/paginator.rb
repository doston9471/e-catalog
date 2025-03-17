class Paginator
  attr_reader :collection, :page, :per_page, :total_count, :total_pages

  MIN_PER_PAGE = 1
  MAX_PER_PAGE = 100
  DEFAULT_PER_PAGE = 10

  def initialize(collection, page: 1, per_page: DEFAULT_PER_PAGE)
    @collection = collection
    @page = [ page.to_i, 1 ].max
    @per_page = validate_per_page(per_page)
    @total_count = collection.count
    @total_pages = calculate_total_pages
  end

  def paginate
    skip = (@page - 1) * @per_page
    paginated_collection = collection.skip(skip).limit(@per_page)

    {
      data: paginated_collection.to_a,
      meta: {
        total_pages: @total_pages,
        current_page: @page,
        total_count: @total_count,
        per_page: @per_page
      }
    }
  end

  def self.paginate(collection, page: 1, per_page: DEFAULT_PER_PAGE)
    new(collection, page: page, per_page: per_page).paginate
  end

  private

  def validate_per_page(value)
    per_page = value.to_i
    per_page = DEFAULT_PER_PAGE if per_page < MIN_PER_PAGE
    per_page = MAX_PER_PAGE if per_page > MAX_PER_PAGE
    per_page
  end

  def calculate_total_pages
    return 1 if @total_count.zero?
    (@total_count.to_f / @per_page).ceil
  end
end
