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
    self.cart_items.collect{ |x| x.quantity * x.product.price }.inject(:+)
  end

  def empty?
  	!self.cart_items.any?
  end
end
