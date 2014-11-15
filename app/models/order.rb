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
  include EventSource

  belongs_to :user

  has_one :address
  has_one :invoice, dependent: :destroy
  has_one :shipment, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :order_events, dependent: :destroy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :shipment, update_only: true
  accepts_nested_attributes_for :invoice, update_only: true

  before_create :build_assotiations, :generate_code, :withdraw_inventory
  after_create :notify_customer, :notify_admins
  after_touch :update_state

  aasm do
    state :in_progress, initial: true
    state :completed
    state :canceled
  end

  def can_cancel?(*)
    !shipment.shipped? && !invoice.paid?
  end

  def total_price
    order_items.map { |x| x.quantity * x.price }.inject(:+)
  end

  private

  def update_state
    aasm_state = :complete if invoice.paid? && shipment.shipped?
    aasm_state = :in_progress if (!invoice.paid? || !shipment.shipped?) && completed?
    save
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
