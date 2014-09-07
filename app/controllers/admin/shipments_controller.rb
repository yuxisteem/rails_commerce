class Admin::ShipmentsController < ApplicationController
  before_action :set_shipment

  def event
    @shipment.send(params[:name].to_sym, nil, current_user)
    @shipment.save
    redirect_to admin_order_path(id: params[:order_id])
  end

  private

  def set_shipment
    @shipment = Order.find(params[:order_id]).shipment
  end
end
