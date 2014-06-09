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
  include AASM

  belongs_to :order, touch: true

  aasm do
    state :pending, initial: true
    state :authorized
    state :paid
    state :refunded
    state :voided

    event :pay do
      transitions from: [:pending, :refunded, :voided, :authorized],
                  to: :paid, on_transition: :log_transition
    end

    event :refund do
      transitions from: :paid, to: :refunded, on_transition: :log_transition
    end
  end

  private

  def log_transition
    OrderHistory.log_transition(order_id, self.class.name,
                                aasm.from_state, aasm.to_state)
  end
end
