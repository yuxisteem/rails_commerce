class Admin::InvoicesController < ApplicationController
  before_action :set_invoice

  def event
    @invoice.send(params[:name].to_sym, nil, current_user)
    @invoice.save
    redirect_to admin_order_path(id: params[:order_id])
  end

  private

  def set_invoice
    @invoice = Order.find(params[:order_id]).invoice
  end
end
