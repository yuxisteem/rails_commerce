class Admin::AddressController < ApplicationController

  before_action :set_address

  def update
    @address.update address_params
    respond_to do |format|
      format.js { head :ok }
    end
  end

  private
    def address_params
      params.require(:address).permit(:city, :street, :phone)
    end

    def set_address
      @address = Address.find params[:id]
    end
end
