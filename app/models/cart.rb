# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  def total_price
    cart_items.map { |x| x.quantity * x.product.price }.inject(:+)
  end

  def empty?
    !cart_items.any?
  end

  def to_order_items
    cart_items.map do |item|
      OrderItem.new(
                      product_id: item.product_id,
                      quantity: item.quantity,
                      price: item.product.price
                    )
    end
  end
end
