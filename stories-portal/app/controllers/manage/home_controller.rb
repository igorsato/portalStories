class Manage::HomeController < Manage::BaseController
  def index
    flash[:notice] = nil
    @orders = Order.joins(:order_status, order_items: :product)
  end
end
