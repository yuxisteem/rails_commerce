class Admin::OrderHistoriesController < Admin::AdminController
  before_action :set_admin_order_history, only: [:show, :edit, :update, :destroy]

  # POST /admin/order_histories
  # POST /admin/order_histories.json
  def create
    @admin_order_history = OrderHistory.new(admin_order_history_params)

    @admin_order_history.order_id = params[:order_id]

    respond_to do |format|
      if !@admin_order_history.note.blank? && @admin_order_history.save
        format.html { redirect_to admin_order_path(@admin_order_history.order_id), notice: 'Order history was successfully created.' }
      else
        format.html { redirect_to admin_order_path(id: @admin_order_history.order_id) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_order_history
      @admin_order_history = OrderHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_order_history_params
      params.require(:order_history).permit(:note).merge(user: current_user)
    end
end
