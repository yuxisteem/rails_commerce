# == Schema Information
#
# Table name: order_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  order_id   :integer
#  quantity   :integer
#  price      :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#

class OrderItem < ActiveRecord::Base
  belongs_to :product

  def self.new_from_cart_item(cart_item)
    OrderItem.new(product_id: cart_item.product_id,
                  quantity: cart_item.quantity,
                  price: cart_item.product.price)
  end
end
