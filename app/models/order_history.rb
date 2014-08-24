# == Schema Information
#
# Table name: order_histories
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  attribute_name :string(255)
#  from_name      :string(255)
#  to_name        :string(255)
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#

class OrderHistory < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  def self.log_transition(order_id, name, from_state, to_state, user)
    OrderHistory.create(order_id: order_id,
                        attribute_name: name,
                        from_name: from_state,
                        to_name: to_state,
                        user: user)
  end
end
