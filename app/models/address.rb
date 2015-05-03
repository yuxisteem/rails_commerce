# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  city       :string(255)
#  street     :string(255)
#  phone      :string(255)
#  order_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_addresses_on_order_id  (order_id)
#

class Address < ActiveRecord::Base
  validates :city, presence: true
  validates :street, presence: true
  validates :phone, presence: true
  belongs_to :order
end
