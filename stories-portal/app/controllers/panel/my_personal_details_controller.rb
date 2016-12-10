class Panel::MyPersonalDetailsController < Panel::BaseController
  def index
    @customer = current_customer
  end
  def customer
    if current_customer.update(customer_params)
      redirect_to panel_my_personal_details_path    
    end
  end
  protected
  def update_resource(resource, params)
    resource.update_without_password(customer_params)
  end  

  private
  def customer_params
  	params.require(:customer).permit(:name, :lastname, :username, :cpf, :password, :password_confirmation, :current_password)
  end  
end
