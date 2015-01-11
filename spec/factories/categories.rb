# == Schema Information
#
# Table name: categories
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  description              :text
#  created_at               :datetime
#  updated_at               :datetime
#  attribute_filter_enabled :boolean          default("true")
#  brand_filter_enabled     :boolean          default("true")
#  weight                   :integer
#  active                   :boolean
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
  	name 'Magic'
  	description 'Category for magical products'
  end
end
