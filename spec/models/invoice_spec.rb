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
# Indexes
#
#  index_invoices_on_aasm_state  (aasm_state)
#  index_invoices_on_order_id    (order_id)
#

require 'spec_helper'

describe Invoice do
  let(:invoice) { create(:invoice) }
  let(:user) { invoice.order.user }

  describe "state machine" do
    it "should have initial In Progress state" do
      expect(invoice.aasm.current_state).to eq(:pending)
    end

    it "should log state transitions" do
      invoice.update(aasm_state: :paid)
      expect(invoice.order.order_events.last.to_state).to eq('paid')
    end
  end
end
