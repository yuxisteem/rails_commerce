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

class ProductAttributeName < ActiveRecord::Base
  include Orderable

  belongs_to :category
  has_many :product_attribute_values, dependent: :destroy
end
