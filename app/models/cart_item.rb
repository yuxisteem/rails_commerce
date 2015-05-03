# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  quantity   :integer          default("1")
#  product_id :integer
#  cart_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_cart_items_on_cart_id     (cart_id)
#  index_cart_items_on_product_id  (product_id)
#

class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
end
