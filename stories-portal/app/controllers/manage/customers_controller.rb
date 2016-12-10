
class Manage::CustomersController < Manage::BaseController
  before_action :set_customer, only: [:show, :update, :edit]
  
  def index
    @customers = Customer.where.not(id: current_customer.id)

		if !params[:search].blank?
			@customers = @customers.searchable("%#{params[:search]}%")
		end
  end 
	def show
		@orders = Order.where(customer_id: params[:id]).page(params[:page]).per(3)
	end
  def new
		@customer = Customer.new
  end
	
	def edit
	end

	def to_param
		super
	end
  def create
  	@customer = Customer.new(customer_params)
  	if @customer.save
			flash[:success] = "Clientes adicionado com sucesso."
  		redirect_to manage_customers_path
  	else
  		render :new
  	end
  end


  def update
		if params[:customer][:password].blank? && params[:customer][:password_confirmation].blank?
				params[:customer].delete(:password)
				params[:customer].delete(:password_confirmation)
		end
  	if @customer.update(customer_params)
			flash[:success] = "Clientes alterada com sucesso."
  		redirect_to manage_customers_path
  	else
  		render :edit
  	end
  end

  private 

  def set_customer
  	@customer = Customer.find params[:id]
  end

  def customer_params
  	params.require(:customer).permit(:name, :lastname, :username, :email, :cpf, :password, :access_id)
  end
end
