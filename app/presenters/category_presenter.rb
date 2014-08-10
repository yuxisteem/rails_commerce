class CategoryPresenter
  include ActiveModel::Translation

  attr_accessor :params

  def initialize(options = {})
    @category_id = options[:category_id]

    # options hash for filtering by attribute values
    @params = options[:params]
    @product_attributes_query = params[:q]
    @brand_ids = params[:brands]
  end

  def products
    products = Product.filter
                      .by_attributes(@product_attributes_query)
                      .where(category_id: @category_id)
                      .includes(:images)
                      .paginate(page: @params[:page])
    products = products.where(brand_id: @brand_ids) if @brand_ids
    products
  end

  def product_attributes
    ProductAttribute
      .where(category_id: @category_id, filterable: true)
      .includes(:product_attribute_values)
  end

  def brands
    Brand.joins(:products)
         .where('products.category_id = ?', @category_id)
  end

  def category
    Category.find(@category_id)
  end
end
