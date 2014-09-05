class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :street
      t.string :phone
      t.references :order, index: true

      t.timestamps
    end
  end
end
