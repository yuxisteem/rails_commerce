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
#

class Category < ActiveRecord::Base
  has_many :products
  has_many :product_attributes, dependent: :destroy
  validates :name, presence: true, length: {maximum: 255}
  validates :description, length: {maximum: 255}

def filters_enabled?
  attribute_filter_enabled || brand_filter_enabled
end

def seo_name
  Transliteration::transliterate(name).parameterize
end

end
