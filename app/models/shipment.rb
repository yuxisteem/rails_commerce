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
  belongs_to    :order, touch: true
  belongs_to    :address

  SHIPPING_METHODS = %w(nova_poshta, self_pickup)

  state_machine :initial => :pending do
    state :pending,       value: 0
    state :ready_to_ship, value: 1
    state :shipped,       value: 2
    state :returned,      value: 3

    after_transition do |shipment, transition|
      OrderHistory.log_transition(transition)
    end

    event :prepare do
      transition [:pending, :returned] => :ready_to_ship
    end

    event :ship do
      transition :ready_to_ship => :shipped
    end

    event :return do
      transition :shipped => :returned
    end
  end

  def shipping_method
    SHIPPING_METHODS[:shipping_method_id]
  end

end
