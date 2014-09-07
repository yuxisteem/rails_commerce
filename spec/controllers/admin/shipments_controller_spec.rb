require 'spec_helper'

describe Admin::ShipmentsController do
  let(:order) { create(:order) }
  before(:each) do
    sign_in(create(:admin))
  end

  describe "order state events" do
    describe "POST shipment_event" do
      it "should change order shipment state" do
        post :event, {order_id: order.id, name: 'prepare'}
      end
    end
  end
end
