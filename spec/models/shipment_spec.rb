require 'spec_helper'

describe Shipment do
  let(:shipment) { create(:shipment) }
  describe 'state machine' do
    it 'should have initial In Progress state' do
      Shipment.new.aasm.current_state.should eq(:pending)
    end

    it 'should log state transitions' do
      shipment.prepare!
      shipment.order.order_histories.last.to_name.should eq('ready_to_ship')
    end
  end
end
