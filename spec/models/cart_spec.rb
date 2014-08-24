# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Cart do
  let(:cart) { create(:cart) }
  describe '#to_order_items' do
    it 'should generate order items' do
      order_items = cart.to_order_items

      expect(order_items.count).to eq(cart.cart_items.count)
      expect(order_items).to be_an(Array)
      expect(order_items.first).to be_an(OrderItem)
    end
  end
end
