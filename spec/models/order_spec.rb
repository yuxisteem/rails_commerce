require 'spec_helper'

describe Order do
  it "should create order from cart" do
  	cart = create(:cart)
  	
  	order = Order.build_from_cart(cart)
  	order.update(user: create(:user), address: create(:address))
  	expect(order.order_items.count).to eq(cart.cart_items.count)
  end

  it "should have invoice generated automatically" do
  	create(:order).invoice.should be_true
  end

  it "should have shipment generated automatically" do
  	create(:order).shipment.should be_true
  end
end
