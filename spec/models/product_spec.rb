# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :text
#  price           :decimal(, )
#  active          :boolean
#  category_id     :integer
#  brand_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  track_inventory :boolean
#  quantity        :integer
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

  describe 'inventory tracking' do
    describe '#in_stock?' do
      describe 'inventory tracking enabled'
        it 'should return true if quantity more than 0' do
        end
        it 'should return false if quantity = 0' do
        end
      end

      describe 'inventory tracking disabled'
        it 'should return true if any quantity' do
        end
      end
    end

    describe '#withdraw' do
      it 'should decrease quantity' do
      end
      it 'should return false if not succeeded' do
      end
    end
  end
end
