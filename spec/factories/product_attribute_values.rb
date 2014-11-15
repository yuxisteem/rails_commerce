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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_attribute_value do
    value Faker::Lorem::word
    product
    product_attribute_name
  end
end
