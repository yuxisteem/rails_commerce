# == Schema Information
#
# Table name: product_attribute_names
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#  filterable  :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  weight      :integer
#
# Indexes
#
#  index_product_attribute_names_on_category_id  (category_id)
#  index_product_attribute_names_on_name         (name)
#

class ProductAttributeName < ActiveRecord::Base
  include Orderable

  belongs_to :category
  has_many :product_attribute_values, dependent: :destroy
end
