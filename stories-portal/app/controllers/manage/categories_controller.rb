class Manage::CategoriesController < Manage::BaseController
	before_action :set_category, only: [:show, :update, :edit, :destroy]
  def index
  	@categories = Category.all.order(updated_at: :desc).page(params[:page])
	 	if !params[:search].blank?
			@categories = @categories.searchable("%#{params[:search]}%")
		end
  end
  def new
  	@category = Category.new
  end
	def destroy
		if @category.destroy
			flash[:success] = "Categoria apagada com sucesso."
			redirect_to manage_categories_path
		else
			flash[:error] = "Não foi possível apagar a Categoria."
			redirect_to manage_categories_path
		end
	end
  def create
  	@category = Category.new(category_params)
  	if @category.save
			flash[:success] = "Categoria criada com sucesso."
  		redirect_to manage_categories_path
  	else
  		render :new
  	end
  end
  def update
  	if @category.update(category_params)
			flash[:success] = "Categoria alterada com sucesso."
  		redirect_to manage_categories_path
  	else
  		render :edit
  	end
  end

  private 

  def set_category
	@category = Category.find_by_slug(params[:id])
	if @category.blank?
  		@category = Category.find params[:id]
	end
  end

  def category_params
  	params.require(:category).permit(:name)
  end
end
