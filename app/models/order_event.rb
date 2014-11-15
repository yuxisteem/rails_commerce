# == Schema Information
#
# Table name: order_events
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  attribute_name :string(255)
#  from_name      :string(255)
#  to_name        :string(255)
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#

class OrderEvent < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  def self.log_transition(order_id, type, from_state, to_state, user)
    OrderEvent.create(order_id: order_id,
                      event_type: type,
                      from_state: from_state,
                      to_state: to_state,
                      user: user)
  end

  def state_changed?
    from_state && to_state
  end
end
