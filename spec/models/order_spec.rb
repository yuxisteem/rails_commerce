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

require 'spec_helper'

describe Order do
  let(:order) { create(:order) }
  let(:user) { order.user }

  it 'should have invoice generated automatically' do
    expect(order.invoice).to be_truthy
  end

  it 'should have shipment generated automatically' do
    expect(order.shipment).to be_truthy
  end

  describe 'state machine' do
    it 'should have initial In Progress state' do
      expect(Order.new.aasm.current_state).to eq(:in_progress)
    end

    it 'should log state transitions' do
      order.update aasm_state: :canceled
      expect(order.order_events.last.to_state).to eq('canceled')
    end

    it 'should be in Completed state if invoice is paid and shipment shipped' do
      order.invoice.update aasm_state: :paid
      order.shipment.update aasm_state: :ready_to_ship
      order.shipment.update aasm_state: :shipped
      expect(order.aasm.current_state).to eq(:completed)
    end

    it 'should be in In Progress state unless invoice is paid and shipment shipped' do
      order.invoice.update aasm_state: :paid
      order.shipment.update aasm_state: :ready_to_ship
      order.shipment.update aasm_state: :shipped
      order.invoice.update aasm_state: :refunded
      expect(order.aasm.current_state).to eq(:in_progress)
    end
  end
end
