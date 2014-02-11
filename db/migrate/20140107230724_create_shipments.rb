class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.references :order, index: true
      t.references :shipping_method, index: true
      t.references :address, index: true
      t.string  :tracking
      t.integer :state

      t.timestamps

      t.index   :state
    end
  end
end
