require 'spec_helper'

describe Admin::OrdersController do
  let(:order) {create(:order)}
  before(:each) do
    sign_in(create(:admin))
  end

  describe "GET index" do
    it "should show all orders" do
      get :index
      expect(response).to be_success
      expect(assigns(:orders).count).to be_true
    end
  end

  describe "GET show" do
    it "should order user by id" do
      get :show, {id: order.id}
      expect(response).to be_success
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "order state events" do
    describe "POST shipment_event" do
      it "should change order shipment state" do
        post :shipment_event, {id: order.id, event: 'prepare'}
      end
    end

    describe "POST invoice_event" do
      it "should change order invoice state" do
        post :invoice_event, {id: order.id, event: 'pay'}
      end
    end

    describe "POST order_event" do
      it "should change order state" do
        post :order_event, {id: order.id, event: 'cancel'}
      end
    end
  end
end
