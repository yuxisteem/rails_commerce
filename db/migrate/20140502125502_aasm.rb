class Aasm < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string
    add_column :invoices, :aasm_state, :string
    add_column :shipments, :aasm_state, :string

    remove_column :orders, :state, :integer
    remove_column :invoices, :state, :integer
    remove_column :shipments, :state, :integer
  end
end
