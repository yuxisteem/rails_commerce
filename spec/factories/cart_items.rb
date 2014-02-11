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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart_item do
  	quantity 1
  	product
  	cart
  end
end
