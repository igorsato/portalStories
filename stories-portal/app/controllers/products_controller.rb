class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_order_item

  def xhr_mail_shipping
    unless params[:zipcode].blank? && !params[:id].blank?
      product = set_product
      package = Correios::Frete::Pacote.new
      item = Correios::Frete::PacoteItem.new :peso => product.weight, 
                                            :comprimento => product.depth, 
                                            :largura => product.width, 
                                            :altura => product.height
      params[:quantity].to_i.times{package.adicionar_item(item)}
      truckage = Correios::Frete::Calculador.new :cep_origem => SOURCE_ZIPCODE,
                                              :cep_destino => params[:zipcode],
                                              :encomenda => package     
      service = truckage.calcular :sedex, :pac
      respond_to do |format|
        format.html{ render body: nil}
        format.json {render json:{"service": service.to_json}}
      end
    end
  end

  private 
  def set_order_item
    @order_item = current_order.order_items.new    
  end
  def set_product
    @product = Product.find_by_slug(params[:id])
    if @product.blank?
      @product = Product.find(params[:id])
    end
  end
end