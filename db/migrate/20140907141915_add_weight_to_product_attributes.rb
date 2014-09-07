class AddWeightToProductAttributes < ActiveRecord::Migration
  def change
    add_column :product_attributes, :weight, :integer
  end
end
