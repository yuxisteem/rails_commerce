class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.boolean :active
      t.references :category, index: true
      t.references :brand, index: true

      t.timestamps

      t.index   :active
    end
  end
end
