class CategoryPresenter
  include ActiveModel::Translation

  attr_accessor :products, :category, :product_attributes, :params, :brands

  def initialize(options = {})
    category_id = options[:category_id]

    # options hash for filtering products by attribute values
    @params = options[:params]
    product_attributes_query = params[:q] || {}
    brand_ids = params[:brands] || []

    @products = filter_products(product_attributes_query, category_id, brand_ids)
                .includes(:images)
                .paginate(page: params[:page])

    @category = Category.find(category_id)

    @brands = Brand.joins(:products)
                   .where('products.category_id = ?', category_id)


    @product_attributes = ProductAttribute
      .where(category_id: category_id, filterable: true)
      .includes(:product_attribute_values)
  end

  private

  def filter_products(query, category_id, brand_ids)
    products =  Product.where(active: true)
    if query.any?
      join_sql = query.map do |key, value|
        attr_values_sql = value.map { |attr_value|
          "#{sanitize('attr_' + key)}.value = #{sanitize(attr_value)}"
        }.join(' OR ')

        %Q(
          INNER JOIN product_attribute_values attr_#{key}
          ON #{sanitize('attr_' + key)}.product_id = products.id
          AND ( #{attr_values_sql} )
        )
      end

      products = products.joins(join_sql).distinct
    else
      # Filter products by category if no attributes given
      products = products.where(category_id: category_id)
    end

    # Filter products by brands
    products = products.where(brand_id: brand_ids) if brand_ids.any?
    products
  end

  def sanitize(str)
    ActiveRecord::Base.sanitize(str)
  end
end
