# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  state      :integer
#  note       :text
#  address_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
  	user
  	address
  	code 'abcdefg123456890'
  	note 'Test note'
  end
end
