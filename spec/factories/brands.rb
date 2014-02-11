# == Schema Information
#
# Table name: brands
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brand do
  	name 'Magic brand'
  	description 'The best brand'
  end
end
