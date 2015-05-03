# == Schema Information
#
# Table name: product_attribute_values
#
#  id                        :integer          not null, primary key
#  value                     :string(255)
#  product_id                :integer
#  product_attribute_name_id :integer
#  created_at                :datetime
#  updated_at                :datetime
#
# Indexes
#
#  index_product_attribute_values_on_product_attribute_name_id  (product_attribute_name_id)
#  index_product_attribute_values_on_product_id                 (product_id)
#  index_product_attribute_values_on_value                      (value)
#

class ProductAttributeValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute_name
  has_one :category, through: :product_attribute_name

  def name
    product_attribute_name.name
  end
end
