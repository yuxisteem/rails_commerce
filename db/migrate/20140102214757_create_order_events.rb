class CreateOrderEvents < ActiveRecord::Migration
  def change
    create_table :order_events do |t|
      t.references :order, index: true
      t.string  :event_type
      t.string  :action_type
      t.string  :from_state
      t.string  :to_state
      t.text    :note

      t.timestamps
    end
  end
end
