class StoreBrowsePresenter
	attr_accessor :products, :category, :product_attributes, :q	 

	def initialize(params ={})
		category_id = params[:category_id]
		self.q = params[:q] || {} # Params hash for filtering products by attributes
		products =  Product.all
		if self.q.any?
			self.q.each_with_index do |attribute, index|			
				
				attributes_values_sql = attribute[1].map {|attribute_value| "attr#{index}.value = #{ActiveRecord::Base.sanitize(attribute_value)}"}.join(' OR ')

				join_sql = %{
					INNER JOIN product_attribute_values attr#{index} 
					ON attr#{index}.product_id = products.id
					AND ( #{attributes_values_sql} )
				}

				products = products.joins(join_sql)
			end
			products = products.distinct.includes(:images)
		else
			products = products.where(category_id: category_id).includes(:images)
		end 

		self.products = products.paginate(page: params[:page])
		self.category = Category.find(category_id)
		self.product_attributes = ProductAttribute.where(category_id: category_id, filterable: true).includes(:product_attribute_values)
	end
end