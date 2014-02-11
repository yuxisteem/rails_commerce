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

class Address < ActiveRecord::Base
end
