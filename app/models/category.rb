# == Schema Information
#
# Table name: categories
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  description              :text
#  created_at               :datetime
#  updated_at               :datetime
#  attribute_filter_enabled :boolean          default(TRUE)
#  brand_filter_enabled     :boolean          default(TRUE)
#  weight                   :integer
#  active                   :boolean
#

class Category < ActiveRecord::Base
  include SeoNames
  include Orderable

  has_many :products
  has_many :product_attribute_names, dependent: :destroy
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }

  scope :active, -> { where(active: true) }

  def filters_enabled?
    attribute_filter_enabled || brand_filter_enabled
  end
end
