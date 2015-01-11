require 'spec_helper'

describe Admin::OrdersController do
  let(:order) {create(:order)}
  before(:each) do
    sign_in(create(:admin))
  end

  describe "#index" do
    it "should show all orders" do
      get :index
      expect(response).to be_success
      expect(assigns(:orders).count).to be_truthy
    end
  end

  describe "#show" do
    it "should order user by id" do
      get :show, {id: order.id}
      expect(response).to be_success
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "#updateorder state events" do
    it "should change order state" do
      put :update, {id: order.id, order: { aasm_state: 'canceled' } }
      expect(assigns(:order).aasm_state).to eq('canceled')
    end
  end
end
