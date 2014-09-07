require 'spec_helper'

describe Admin::InvoicesController do
  let(:order) { create(:order) }
  before(:each) do
    sign_in(create(:admin))
  end

  describe "order state events" do
    describe "POST invoice_event" do
      it "should change order invoice state" do
        post :event, {order_id: order.id, name: 'pay'}
      end
    end
  end
end
