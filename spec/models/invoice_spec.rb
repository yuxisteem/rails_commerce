# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  payment_method :integer
#  amount         :decimal(, )
#  invoice_type   :string(255)
#  aasm_state     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

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
