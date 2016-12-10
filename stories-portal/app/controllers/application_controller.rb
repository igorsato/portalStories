class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :user, contains: [:customer]
  before_action :current_order
  before_action :set_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_order, :current_access
  
  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
  def check_session
    if customer_signed_in? 
      if !current_access.admin?
        # redirect_to root_path
        raise ActionController::RoutingError.new("No route matches  [GET] #{request.fullpath}")
      end
    else
      # redirect_to login_path
      raise ActionController::RoutingError.new("No route matches [GET] #{request.fullpath}")
    end
  end
  
  def shipping
    if !params[:shipping].blank?
      package = Correios::Frete::Pacote.new
      current_order.order_items.each do |order_item|
        item = Correios::Frete::PacoteItem.new :peso => order_item.product.weight, 
                                               :comprimento => order_item.product.depth, 
                                               :largura => order_item.product.width, 
                                               :altura => order_item.product.height
        order_item.quantity.times{package.adicionar_item(item)}
      end
      truckage = Correios::Frete::Calculador.new :cep_origem => SOURCE_ZIPCODE,
                                              :cep_destino => params[:shipping],
                                              :encomenda => package
      service = truckage.calcular :sedex, :pac
      respond_to do |format|
        format.html{ render body: nil}
        format.json {render json:{"service": service.to_json}}
      end    
    end
  end  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password]) 
  end

  private 

  def render_bad_request
    # render ..., :status => 400
  end  
  def after_sign_out_path_for(resource_or_scope)
		URI.parse(request.referer).path if request.referer
    return root_path
	end

  def current_access
    current_customer.access if current_customer
  end 

  def set_categories
    @categories = Category.all
  end
end
