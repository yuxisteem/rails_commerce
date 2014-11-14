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
      expect(assigns(:orders).count).to be_truthy
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
    describe "POST order_event" do
      context "for order" do
        it "should change order state" do
          post :event, {id: order.id, name: 'cancel'}
        end
      end

      context "for shipment" do
        it "should change order state" do
          post :event, {id: order.id, name: 'prepare', type: 'shipment'}
        end
      end

      context "for invoice" do
        it "should change order state" do
          post :event, {id: order.id, name: 'pay', type: 'invoice'}
        end
      end
    end
  end
end
