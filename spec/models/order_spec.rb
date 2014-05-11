# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  state      :integer
#  note       :text
#  address_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Order do
  let(:order) {create(:order)}

  it "should create order from cart" do
  	cart = create(:cart)

  	order = Order.build_from_cart(cart)
  	order.update(user: create(:user), address: create(:address))
  	expect(order.order_items.count).to eq(cart.cart_items.count)
  end

  it "should have invoice generated automatically" do
  	order.invoice.should be_true
  end

  it "should have shipment generated automatically" do
  	order.shipment.should be_true
  end

  describe "state machine" do
    it "should have initial In Progress state" do
      Order.new.aasm.current_state.should eq(:in_progress)
    end

    it "should log state transitions" do
      order.cancel!
      order.order_histories.last.to_name.should eq('canceled')
    end

    it "should be in Completed state if invoice is paid and shipment shipped" do
      order.invoice.pay!
      order.shipment.prepare!
      order.shipment.ship!
      order.aasm.current_state.should eq(:completed)
    end

    it "should be in In Progress state unless invoice is paid and shipment shipped" do
      order.invoice.pay!
      order.shipment.prepare!
      order.shipment.ship!
      order.invoice.refund!
      order.aasm.current_state.should eq(:in_progress)
    end

    it "should be cancelable if not shipped and not paid" do
      order.may_cancel?.should be_true
    end

    it "should not be cancelable if shipped or paid" do
      order.invoice.pay
      order.may_cancel?.should be_false
    end
  end
end
