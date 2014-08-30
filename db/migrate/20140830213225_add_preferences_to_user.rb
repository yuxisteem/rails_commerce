class AddPreferencesToUser < ActiveRecord::Migration
  def change
    add_column :users, :receive_sms, :boolean, default: true
    add_column :users, :receive_email, :boolean, default: true
  end
end
