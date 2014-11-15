# == Schema Information
#
# Table name: 
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

require 'spec_helper'

describe OrderEvent do
  let(:order) { create(:order) }
  it '#log_transition should log log order state transitions' do
    OrderEvent.log_transition(order.id, 'transition name', 'from state', 'to state', order.user)
    order_event = OrderEvent.last
    expect(order_event.order_id).to eq(order.id)
    expect(order_event.from_name).to eq('from state')
    expect(order_event.to_name).to eq('to state')
  end
end
