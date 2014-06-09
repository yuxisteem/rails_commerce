# == Schema Information
#
# Table name: product_attribute_values
#
#  id                   :integer          not null, primary key
#  value                :string(255)
#  product_id           :integer
#  product_attribute_id :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class ProductAttributeValue < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute
  has_one :category, through: :product_attribute

  def name
    product_attribute.name
  end
end
