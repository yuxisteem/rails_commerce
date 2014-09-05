# == Schema Information
#
# Table name: brands
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  weight      :integer
#

class Brand < ActiveRecord::Base
  include Orderable

  has_many :products
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
end
