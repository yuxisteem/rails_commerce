# == Schema Information
#
# Table name: product_attributes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#  filterable  :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_attribute do
    name Faker::Lorem::word
  end
end
