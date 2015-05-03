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
  before_save :update_state

  aasm do
    state :in_progress, initial: true
    state :completed
    state :canceled

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :put_in_progress do
      transitions from: [:completed, :canceled], to: :in_progress
    end
  end

  def total_price
    order_items.map { |x| x.quantity * x.price }.reduce(:+)
  end

  private

  def update_state
    return unless persisted?
    complete if invoice.paid? && shipment.shipped? && !completed?
    put_in_progress if !(invoice.paid? && shipment.shipped?) && completed?
    # binding.pry
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
    OrderNotifier.order_received(id).deliver_later
    OrderSMSNotifier.order_received(id)
  end

  def notify_admins
    OrderNotifier.order_placed_admin(id).deliver_later
    OrderSMSNotifier.order_placed_admin(id)
  end
end
