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

require 'spec_helper'

describe OrderHistory do
  let(:order) { create(:order) }
  it '#log_transition should log log order state transitions' do
    OrderHistory.log_transition(order.id, 'transition name', 'from state', 'to state', order.user)
    order_history = OrderHistory.last
    order_history.order_id.should eq(order.id)
    order_history.from_name.should eq('from state')
    order_history.to_name.should eq('to state')
  end
end
