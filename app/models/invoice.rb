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

class Invoice < ActiveRecord::Base
  include AASM
  include EventSource

  belongs_to :order

  aasm do
    state :pending, initial: true
    state :authorized
    state :paid
    state :refunded
    state :voided
  end
end
