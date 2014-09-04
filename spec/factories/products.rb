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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
  	name 'Product'
  	description 'Product description'
  	price 1234
  	active true
  	brand
  	category
  end
end
