# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  payment_method :integer
#  amount         :decimal(, )
#  invoice_type   :string(255)
#  state          :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Invoice < ActiveRecord::Base

  belongs_to		:order, touch: true

  state_machine :initial => :pending do
    state :pending,		value: 0
    state :authorized,	value: 1
    state :paid,		value: 2
    state :refunded,	value: 3
    state :voided,		value: 4

    after_transition do |invoice, transition|
      OrderHistory.log_transition(transition)
    end

    event :pay do
      transition [:pending, :refunded, :voided, :authorized] => :paid
    end

    event :refund do
      transition :paid => :refunded
    end
  end

end
