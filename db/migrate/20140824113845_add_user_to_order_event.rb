class AddUserToOrderEvent < ActiveRecord::Migration
  def change
    add_column :order_events, :user_id, :integer
  end
end
