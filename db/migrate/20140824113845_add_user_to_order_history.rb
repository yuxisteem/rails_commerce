class AddUserToOrderHistory < ActiveRecord::Migration
  def change
    add_column :order_histories, :user_id, :integer
  end
end
