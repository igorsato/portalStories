class Manage::ProductsController < Manage::BaseController
	before_action :set_product, only: [:show, :update, :edit, :gallery_change]
  def index
  	@products = Product.all.order(updated_at: :desc).page(params[:page])
  end

  def new
  	@product = Product.new
  end

  def edit
  end

  def create
  	@product = Product.new(product_param)
  	if @product.save
      gallery_create
  		redirect_to manage_products_path
  	else
  		render :new
  	end
  end

  def update
    if @product.update(product_param)
      redirect_to manage_products_path
    else
      render :edit
    end
  end

  def gallery_change
    if params[:media].blank?
      gallery_create
    else
      gallery_remove
    end
    render body: nil
  end

  private 
  def gallery_remove
    gallery = Gallery.find params[:media]
    @product.pictures.destroy(gallery)
  end
  def gallery_create
    if !params[:product][:pictures].blank? && !params[:product][:pictures][:media].blank?
      params[:product][:pictures][:media].each do |media|
        @product.pictures << Gallery.create(media: media)
      end 
    end
  end

  def set_product
      @product = Product.find_by_slug(params[:id])
      if @product.blank?
        @product = Product.find(params[:id])
      end
  end
  def product_param
  	params.require(:product).permit(:name, :description, :description_short, :sku, :featured, :active, :cost_price, :sale_price, :promotional_price, :weight, :height, :width, :depth, :balance, category_ids: [], pictures: [])
  end
end
