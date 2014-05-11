# == Schema Information
#
# Table name: shipments
#
#  id                 :integer          not null, primary key
#  order_id           :integer
#  shipping_method_id :integer
#  address_id         :integer
#  tracking           :string(255)
#  state              :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Shipment < ActiveRecord::Base

  include AASM

  belongs_to    :order, touch: true
  belongs_to    :address

  SHIPPING_METHODS = %w(nova_poshta, self_pickup)

  aasm do
    state :pending, initial: true
    state :ready_to_ship
    state :shipped
    state :returned

    event :prepare do
      transitions from: [:pending, :returned], to: :ready_to_ship, on_transition: :log_transition
    end

    event :ship do
      transitions from: :ready_to_ship, to: :shipped, on_transition: :log_transition
    end

    event :return do
      transitions from: :shipped, to: :returned, on_transition: :log_transition
    end
  end

  def shipping_method
    SHIPPING_METHODS[:shipping_method_id]
  end

  private

  def log_transition
    OrderHistory.log_transition(order_id, self.class.name, aasm.from_state, aasm.to_state)
  end
end
