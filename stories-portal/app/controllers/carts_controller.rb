class CartsController < ApplicationController
  def show
    @order_items = current_order.order_items
  end

  def postal_code
    if !params[:postal_code_value].blank?
      current_order.update({shipping: params[:postal_code_value]})
    end
    respond_to do |format|
      format.html { render body: nil}
      format.json { render json: {'total_cart': current_order.final_total}}
    end
  end
  private 
  def set_cart_params
    params.require(:order).permit(:shipping)
  end
end
