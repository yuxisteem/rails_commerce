class AddInventoryToProduct < ActiveRecord::Migration
  def change
    add_column :products, :track_inventory, :boolean, default: false
    add_column :products, :quantity, :integer, default: 0
  end
end
