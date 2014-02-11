class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.string :code
      t.integer :state
      t.text :note
      t.references :user, index: true

      t.timestamps

      t.index :state
      t.index :code
    end
  end
end
