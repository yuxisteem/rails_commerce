# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  price       :decimal(, )
#  active      :boolean
#  category_id :integer
#  brand_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Product do
  it 'should be cloneable' do
    product = create(:product)

    clone = product.clone
    product.name.should match(clone.name)
    product.description.should match(clone.description)
    product.product_attribute_values.should match_array(clone.product_attribute_values)
  end
end
