# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  state      :integer
#  note       :text
#  address_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Order < ActiveRecord::Base
  include AASM

  before_create :generate_shippment, :generate_invoice, :generate_code
  after_create :send_mail
  after_touch :update_state

  belongs_to :user

  has_one :address
  has_one :invoice, dependent: :destroy
  has_one :shipment, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :order_histories, dependent: :destroy

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

  def can_cancel?
    !shipment.shipped? && !invoice.paid?
  end

  def self.build_from_cart(cart)
    order = Order.new
    cart.cart_items.each do |x|
      order.order_items.append(OrderItem.create(
                               product_id: x.product_id,
                               quantity: x.quantity,
                               price: x.product.price
      ))
    end
    order
  end

  def total_price
    order_items.map { |x| x.quantity * x.price }.inject(:+)
  end

  def previous
    Order.find_by_id(id - 1)
  end

  def next
    Order.find_by_id(id + 1)
  end

  private

  def log_transition
    # TODO: log human readable states, e.g. ready_to_ship --> Ready to ship
    OrderHistory.log_transition(id, self.class.name,
                                aasm.from_state, aasm.to_state)
  end

  def update_state
    complete! if invoice.paid? && shipment.shipped?
    put_in_progress! if (!invoice.paid? || !shipment.shipped?) && completed?
  end

  def generate_shippment
    self.shipment = Shipment.new(address: address)
  end

  def generate_invoice
    self.invoice = Invoice.new(amount: total_price)
  end

  def generate_code
    self.code = SecureRandom.hex
  end

  def send_mail
    OrderNotifier.order_received(id).deliver
  end
end
