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
    it 'should have initial "in progress" state' do
      expect(order.aasm.current_state).to eq(:in_progress)
    end

    context 'when order changes state' do
      before { order.update aasm_state: :canceled }

      it 'should log state transitions' do
        expect(order.order_events.last.to_state).to eq('canceled')
      end
    end

    context 'when invoice is "paid" and and shipment is "shipped"' do
      before do
        order.update invoice_attributes: { aasm_state: :paid }, shipment_attributes: { aasm_state: :shipped }
      end

      it 'should be in "completed" state' do
        expect(order.aasm.current_state).to eq(:completed)
      end
    end

    context 'when invoice is not "paid" and or shipment is not "shipped"' do
      before do
        order.update invoice_attributes: { aasm_state: :paid }, shipment_attributes: { aasm_state: :shipped }
        order.update invoice_attributes: { aasm_state: :refunded }, shipment_attributes: { aasm_state: :returned }
      end

      it 'should be in "in progress" state' do
        expect(order.aasm.current_state).to eq(:in_progress)
      end
    end
  end
end
