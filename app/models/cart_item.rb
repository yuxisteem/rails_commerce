# == Schema Information
#
# Table name: cart_items
#
#  id         :integer          not null, primary key
#  quantity   :integer          default(1)
#  product_id :integer
#  cart_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
end
