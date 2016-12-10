class CheckoutController < ApplicationController
  before_action :set_customer, only: [:index, :customer]
  before_action :authenticate_user!
  before_action :set_cache_headers
  def index    
    @customer.addresses.build
    if session[:order_id].nil? || current_order.order_items.count < 1
      redirect_to root_path
    end    
  end 
  
  def customer
    if !session[:order_id].nil?
      if @customer.update(customer_params)
        payment = Payment.new
        unless params[:options_shipping].blank?
          payment.name = params[:options_shipping] 
          payment.active = true
          payment.save
        end
        if @customer.addresses.count == 1
          address_id = @customer.addresses.first.id
        else
          address_id = params[:address_id]
        end
        if current_order.update({shipping:  params[:shipping_value], shipping_name: params[:shipping_name], customer: @customer, order_number: 1000 + current_order.id, total: current_order.final_total, payment: payment, order_status_id: 2, address_id: address_id})
          flash[:notice] = current_order.order_number
          session[:order_id] = nil   
          redirect_to success_path
        end
      else
        redirect_to checkout_path, flash: { error: 'Preencher com um endereço de entrega.'}          
      end
    else
      redirect_to root_path
    end
  end
  def order_success
    if flash[:notice].nil?
      redirect_to root_path
    end
  end
  private
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Thu, 01 Jan 1970 00:00:00 GMT"
  end  
  def set_customer
    @customer = current_customer
  end
  
  def customer_params
    address = nil
    if @customer.addresses.count < 1
      address = {addresses_attributes: [:alias, :postal_code, :main_address, :number, :street, :complement, :neighborhood, :city, :state_id]}
    end
  	params.require(:customer).permit(:name, :email, :lastname, :cpf, address)
  end

end
