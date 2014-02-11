class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :order, index: true
      t.integer :payment_method
      t.decimal :amount
      t.string  :invoice_type
      t.integer :state

      t.timestamps

      t.index :state
    end
  end
end
