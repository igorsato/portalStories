class HomeController < ApplicationController
  
  def index
  	@home = "Feira dos Cosméticos"
  	@lauch_products = Product.where(created_at: (Time.now - 7.day)..Time.now).limit(8)
    @top_selling_products = OrderItem.all.order(quantity: :desc).limit(3)
    @featured_products = Product.where(active: true, featured: true).limit(6)
  end
end