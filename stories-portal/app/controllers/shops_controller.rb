class ShopsController < ApplicationController
  
  before_action :set_category, :set_instances
  
  def index
    @products = Product.all
    if !params[:orderby].blank?
      @products = @products.order("promotional_price #{params[:orderby].upcase}, sale_price #{params[:orderby].upcase}")
    end
    range_price
    orderby
    if !params[:search].blank?  
      search
    end
    @products = @products.page(params[:page]).per(9)
    @order_item = current_order.order_items.new
  end
  
  def show
    render :index
  end

  def search
    @products = Product.where("products.slug LIKE ? OR products.name LIKE ? OR products.sku LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
  end
  private 
  def orderby
    if !params[:orderby].blank?
      @products = @products.order("promotional_price #{params[:orderby]}, sale_price #{params[:orderby]}")
    end
  end
  def range_price
    if !params[:range_price].blank?
      price = params[:range_price].split(';')
      @products = @products.where("sale_price BETWEEN ? AND ?", price[0].to_f, price[1].to_f)
    end
  end 

  def set_instances
    @categories = Category.all
    @latest_news = Product.where(created_at: (Time.now.midnight - 7.day)..Time.now.midnight).limit(5) 
  end

  def set_category
     if !params[:id].blank?
      @category = Category.find_by_slug(params[:id])
      if @category.blank?
        @category = Category.find(params[:id])
      end
      @products = @category.products
      range_price
      orderby
      @products = @products.page(params[:page]).per(9)    

    end
  end
end
