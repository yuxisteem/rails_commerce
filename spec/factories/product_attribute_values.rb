# == Schema Information
#
# Table name: product_attribute_values
#
#  id                        :integer          not null, primary key
#  value                     :string(255)
#  product_id                :integer
#  product_attribute_name_id :integer
#  created_at                :datetime
#  updated_at                :datetime
#
# Indexes
#
#  index_product_attribute_values_on_product_attribute_name_id  (product_attribute_name_id)
#  index_product_attribute_values_on_product_id                 (product_id)
#  index_product_attribute_values_on_value                      (value)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_attribute_value do
    value Faker::Lorem::word
    product
    product_attribute_name
  end
end
