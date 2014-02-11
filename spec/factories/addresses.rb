# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  city       :string(255)
#  street     :string(255)
#  phone      :string(255)
#  order_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
  	city 'Odessa'
  	street 'Bazarnaya str. 91-9'
  	phone '+380634150427'
  end
end

