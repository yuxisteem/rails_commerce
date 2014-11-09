# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :text
#  price           :decimal(, )
#  active          :boolean
#  category_id     :integer
#  brand_id        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  track_inventory :boolean          default(FALSE)
#  quantity        :integer          default(0)
#

class Product < ActiveRecord::Base
  include Filterable
  include SeoNames

  belongs_to :category
  belongs_to :brand
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 2048 }
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :price, presence: true, numericality: true
  has_many :images, as: :imageable, dependent: :destroy
  has_many :product_attribute_values, dependent: :destroy

  accepts_nested_attributes_for :product_attribute_values

  before_update :clear_attributes

  scope :active, -> { where(active: true) }

  def in_stock?
    track_inventory? ? quantity > 0 : true
  end

  def withdraw(q)
    transaction do
      return true unless track_inventory
      (quantity - q >= 0) ? update(quantity: quantity - q) : false
    end
  end

  def available_attributes
    @available_attributes ||=
    transaction do
      if category.product_attribute_names.any?
        category.product_attribute_names.map do |x|
          ProductAttributeValue
            .find_or_initialize_by(product_id: id,
                                   product_attribute_name_id: x.id)
        end
      end
    end
  end

  private

  # Remove existing attributes values if we changed product's category
  def clear_attributes
    return true unless category_id_changed?
    transaction do
      product_attribute_values.each { |x| x.delete }
    end
  end
end
