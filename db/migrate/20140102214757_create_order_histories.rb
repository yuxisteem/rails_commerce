class CreateOrderHistories < ActiveRecord::Migration
  def change
    create_table :order_histories do |t|
      t.references :order, index: true
      t.string  :attribute_name
      t.string  :from_name
      t.string  :to_name
      t.text    :note

      t.timestamps
    end
  end
end
