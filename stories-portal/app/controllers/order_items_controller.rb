class OrderItemsController < ApplicationController

  def create
    @order = current_order
    if @order.order_items.where(product_id: params[:order_item][:product_id]).blank?
      @order_item = @order.order_items.new(order_item_params)
      if @order.save
        session[:order_id] = @order.id
      end
    else
      order_item = @order.order_items.where(product_id: params[:order_item][:product_id]).last
      quantity = order_item.quantity + params[:order_item][:quantity].to_i
      if order_item.update_attributes({quantity: quantity})
        @order_items = @order.order_items
        @order.save
      end
    end
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.js   {render controller: :shops}
      format.json { render :show, status: :created }
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    if @order_item.update_attributes(order_item_params)
      @order_items = @order.order_items
      @order.save
    end
    redirect_to cart_path
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])    
    @order_item.destroy
    @order_items = @order.order_items
    if @order_items.blank?
      session[:order_id] = nil
      @order.destroy
    end
    redirect_to cart_path
  end

  private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
