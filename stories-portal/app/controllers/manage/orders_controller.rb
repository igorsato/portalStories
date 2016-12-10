class Manage::OrdersController < Manage::BaseController
  before_action :set_order, only: [:show]
  def index
    @orders = Order.all.order(updated_at: :desc).page(params[:page])
  end
  private 
  def set_order
    @order = Order.find params[:id]
  end
end
