class CreateProductAttributeNames < ActiveRecord::Migration
  def change
    create_table :product_attribute_names do |t|
      t.string :name
      t.references :category, index: true
      t.boolean :filterable

      t.timestamps

      t.index :name
    end
  end
end
