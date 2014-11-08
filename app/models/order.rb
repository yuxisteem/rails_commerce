# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  aasm_state :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  include AASM

  belongs_to :user

  has_one :address
  has_one :invoice, dependent: :destroy
  has_one :shipment, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :order_histories, dependent: :destroy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :user

  before_create :build_assotiations, :generate_code, :withdraw_inventory
  after_create :notify_customer, :notify_admins
  after_touch :update_state

  aasm do
    state :in_progress, initial: true
    state :completed
    state :canceled

    event :complete do
      transitions from: :in_progress,
                  to: :completed, on_transition: :log_transition
    end

    event :cancel do
      transitions from: [:in_progress, :completed],
                  to: :canceled, on_transition: :log_transition,
                  guards: :can_cancel?
    end

    event :resume do
      transitions from: :canceled,
                  to: :in_progress, on_transition: :log_transition
    end

    event :put_in_progress do
      transitions from: :completed,
                  to: :in_progress, on_transition: :log_transition
    end
  end

  def can_cancel?(*)
    !shipment.shipped? && !invoice.paid?
  end

  def total_price
    order_items.map { |x| x.quantity * x.price }.inject(:+)
  end

  private

  def log_transition(user = nil)
    # We pass user object as argument to event when firing
    # event from Controller to know who had triggered an event

    # TODO: log human readable states, e.g. ready_to_ship --> Ready to ship
    OrderHistory.log_transition(id, self.class.name,
                                aasm.from_state, aasm.to_state, user)
  end

  def update_state
    complete! if invoice.paid? && shipment.shipped?
    put_in_progress! if (!invoice.paid? || !shipment.shipped?) && completed?
  end

  def build_assotiations
    build_shipment(address: address)
    build_invoice(amount: total_price)
  end

  def withdraw_inventory
    order_items.each { |item| item.product.withdraw item.quantity }
  end

  def generate_code
    self.code = SecureRandom.hex
  end

  def notify_customer
    OrderNotifier.order_received(id).deliver
    OrderSMSNotifier.order_received(id)
  end

  def notify_admins
    OrderNotifier.order_placed_admin(id).deliver
    OrderSMSNotifier.order_placed_admin(id)
  end
end
