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
#  track_inventory :boolean          default(FALSE)
#  quantity        :integer          default(0)
#

require 'spec_helper'

describe Product do
  let(:product) { create(:product) }

  describe '#clone' do
    it 'should clone product' do

      clone = product.clone
      expect(product.name).to match(clone.name)
      expect(product.description).to match(clone.description)
      expect(product.product_attribute_values)
             .to match_array(clone.product_attribute_values)
    end
  end

  describe 'inventory tracking' do
    describe '#in_stock?' do
      describe 'inventory tracking enabled' do
        it 'should return true if quantity more than 0' do
          product.track_inventory = true
          product.quantity = 10

          expect(product.in_stock?).to be_truthy
        end

        it 'should return false if quantity = 0' do
          product.track_inventory = true
          product.quantity = 0

          expect(product.in_stock?).to be_falsey
        end
      end

      describe 'inventory tracking disabled' do
        it 'should return true if no items left' do
          product.track_inventory = false
          product.quantity = 0

          expect(product.in_stock?).to be_truthy
        end
      end
    end

    describe '#withdraw' do
      it 'should decrease quantity' do
        product.track_inventory = true
        product.quantity = 10

        expect(product.withdraw 1).to be_truthy
        expect(product.quantity).to eq 9
      end

      it 'should return false if not succeeded' do
        product.track_inventory = true
        product.quantity = 0

        expect(product.withdraw 1).to be_falsey
      end
    end
  end
end
