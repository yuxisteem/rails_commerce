# == Schema Information
#
# Table name: shipments
#
#  id                 :integer          not null, primary key
#  order_id           :integer
#  shipping_method_id :integer
#  address_id         :integer
#  tracking           :string(255)
#  aasm_state         :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Shipment < ActiveRecord::Base
  include AASM

  belongs_to :order
  belongs_to :address

  aasm do
    state :pending, initial: true
    state :ready_to_ship
    state :shipped
    state :returned
  end

  private

  def log_transition(user = nil)
    OrderHistory.log_transition(order_id, self.class.name,
                                aasm.from_state, aasm.to_state, user)
  end
end
