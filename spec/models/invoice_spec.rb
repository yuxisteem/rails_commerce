require 'spec_helper'

describe Invoice do
  let(:invoice) {create(:invoice)}
  describe "state machine" do
    it "should have initial In Progress state" do
      Invoice.new.aasm.current_state.should eq(:pending)
    end

    it "should log state transitions" do
      invoice.pay!
      invoice.order.order_histories.last.to_name.should eq('paid')
    end
  end
end