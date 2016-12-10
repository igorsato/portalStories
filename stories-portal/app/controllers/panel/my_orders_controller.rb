class Panel::MyOrdersController < Panel::BaseController 
  def index
    @orders = Order.where(customer_id: current_user).order(updated_at: :desc).page(params[:page]).per(5)
  end
end
