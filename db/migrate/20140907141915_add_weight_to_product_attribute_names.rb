class AddWeightToProductAttributeNames < ActiveRecord::Migration
  def change
    add_column :product_attribute_names, :weight, :integer
  end
end
