class CreateProductAttributeValues < ActiveRecord::Migration
  def change
    create_table :product_attribute_values do |t|
      t.string :value
      t.references :product, index: true
      t.references :product_attribute_name, index: true

      t.timestamps

      t.index :value
    end
  end
end
