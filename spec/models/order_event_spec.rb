# == Schema Information
#
# Table name: order_events
#
#  id          :integer          not null, primary key
#  order_id    :integer
#  event_type  :string(255)
#  action_type :string(255)
#  from_state  :string(255)
#  to_state    :string(255)
#  note        :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#
# Indexes
#
#  index_order_events_on_order_id  (order_id)
#

require 'spec_helper'

describe OrderEvent do
  let(:order) { create(:order) }
  it '#log_transition should log log order state transitions' do
    OrderEvent.log_transition(order.id, 'transition name', 'from state', 'to state', order.user)
    order_event = OrderEvent.last
    expect(order_event.order_id).to eq(order.id)
    expect(order_event.from_state).to eq('from state')
    expect(order_event.to_state).to eq('to state')
  end
end
