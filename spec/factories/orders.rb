# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  aasm_state :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_orders_on_aasm_state  (aasm_state)
#  index_orders_on_code        (code)
#  index_orders_on_user_id     (user_id)
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
