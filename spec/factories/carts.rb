# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cart do
    # items_count is declared as an ignored attribute and available in
    # attributes on the factory, as well as the callback via the evaluator
    ignore do
      items_count 5
    end

    # the after(:create) yields two values; the user instance itself and the
    # evaluator, which stores all values from the factory, including ignored
    # attributes; `create_list`'s second argument is the number of records
    # to create and we make sure the cart is associated properly to the cart_item
    after(:create) do |cart, evaluator|
      create_list(:cart_item, evaluator.items_count, cart: cart)
    end
  end
end
