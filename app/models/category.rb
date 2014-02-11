# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Category < ActiveRecord::Base
  has_many :products
  has_many :product_attributes, dependent: :destroy
  validates :name, presence: true, length: {maximum: 255}
  validates :description, length: {maximum: 255}
end
