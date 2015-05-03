# == Schema Information
#
# Table name: shipments
#
#  id                 :integer          not null, primary key
#  order_id           :integer
#  shipping_method_id :integer
#  address_id         :integer
#  tracking           :string(255)
#  aasm_state         :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_shipments_on_aasm_state          (aasm_state)
#  index_shipments_on_address_id          (address_id)
#  index_shipments_on_order_id            (order_id)
#  index_shipments_on_shipping_method_id  (shipping_method_id)
#

require 'spec_helper'

describe Shipment do
  let(:shipment) { create(:shipment) }
  let(:user) { shipment.order.user }

  describe 'state machine' do
    it 'should have initial In Progress state' do
      expect(shipment.aasm.current_state).to eq(:pending)
    end

    it 'should log state transitions' do
      shipment.update(aasm_state: :ready_to_ship)
      expect(shipment.order.order_events.last.to_state).to eq('ready_to_ship')
    end
  end
end
