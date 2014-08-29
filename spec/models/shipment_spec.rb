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

require 'spec_helper'

describe Shipment do
  let(:shipment) { create(:shipment) }
  let(:user) { shipment.order.user }

  describe 'state machine' do
    it 'should have initial In Progress state' do
      Shipment.new.aasm.current_state.should eq(:pending)
    end

    it 'should log state transitions' do
      shipment.prepare!(nil, user)
      shipment.order.order_histories.last.to_name.should eq('ready_to_ship')
    end
  end
end
