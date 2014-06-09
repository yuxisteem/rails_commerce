class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :order, index: true
      t.integer :payment_method
      t.decimal :amount
      t.string  :invoice_type
      t.string :aasm_state

      t.timestamps

      t.index :aasm_state
    end
  end
end
