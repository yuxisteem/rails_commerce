class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :product, index: true
      t.references :order, index: true
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
