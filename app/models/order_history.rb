# == Schema Information
#
# Table name: order_histories
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  attribute_name :string(255)
#  from_name      :string(255)
#  to_name        :string(255)
#  note           :text
#  created_at     :datetime
#  updated_at     :datetime
#

class OrderHistory < ActiveRecord::Base
  belongs_to :order
  belongs_to :user

  def self.log_transition(transition)
    object = transition.object
    #Transition object could be Order itself or it's related object (e.g. shipment, invoice...)
    OrderHistory.create(order_id: object.try(:order_id) || object.id,
                        attribute_name: object.class.name,
                        from_name: transition.human_from_name,
                        to_name: transition.human_to_name)
  end
end
