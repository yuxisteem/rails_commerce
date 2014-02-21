class StoreBrowsePresenter
	attr_accessor :products, :category, :product_attributes, :q, :brands

	def initialize(params ={})
		category_id = params[:category_id]

		# Params hash for filtering products by attribute values
		@product_attributes = params[:q] || {}
		@brand_ids = params[:brands] || {}

		@products =  Product.all
		if @product_attributes.any?
			@product_attributes.each_with_index do |attribute, i|
				
				attr_values_sql = attribute[1].map {|attr_value| "attr#{i}.value = #{ActiveRecord::Base.sanitize(attr_value)}"}.join(' OR ')

				join_sql = %{
					INNER JOIN product_attribute_values attr#{i} 
					ON attr#{i}.product_id = products.id
					AND ( #{attr_values_sql} )
				}

				@products = @products.joins(join_sql)
			end
			@products = @products.distinct.includes(:images)
		else
			# Filter products by category if no attributes given
			@products = @products.where(category_id: category_id).includes(:images)
		end

		# Filter products by brands
		@products = @products.where(brand_id: @brand_ids) if @brand_ids.any? 

		@products = @products.paginate(page: params[:page])
		@category = Category.find(category_id)
		@brands = Brand.where(id: @products.map(&:brand_id).uniq)
		@product_attributes = ProductAttribute.where(category_id: category_id, filterable: true).includes(:product_attribute_values)
	end
end
