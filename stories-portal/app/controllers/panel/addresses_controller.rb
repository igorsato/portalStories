class Panel::AddressesController < Panel::BaseController 
  before_action :set_address, only: [:edit, :update, :destroy, :xhr_update]
  before_action :set_addresses, only: [:index, :create, :xhr_update]
  def index
    @address = Address.new
  end
  def edit
  end
  def destroy
    if @address.destroy
      if @address.postal_code == cookies[:cep]
        cookies.delete :cep
      end
      redirect_to panel_addresses_path
    end
  end
  def xhr_update
    if !params[:main_address].blank? && !params[:id].blank?
      @address.update({main_address: params[:main_address]})
      redirect_to panel_addresses_path
    end
  end
  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to panel_addresses_path
    else
      render :index
    end
  end

  private
  def set_addresses
    @addresses = Address.where(customer_id: current_customer.id).order(main_address: :desc, updated_at: :desc).page(params[:page]).per(3)    
  end
  def set_address
    @address = Address.find params[:id]
  end
  def address_params
    params.require(:address).permit(:alias, :main_address, :postal_code, :number, :type_address, :street, :complement, :reference, :neighborhood, :city, :state_id, :customer_id)
  end
end
