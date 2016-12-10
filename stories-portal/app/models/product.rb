class Product < ApplicationRecord
	before_save :create_slug, :capitalized

	has_and_belongs_to_many :categories, join_table: :categories_has_products, uniq: true, dependent: :destroy
	has_many :order_items

	has_many :pictures, class_name: Gallery, as: :attachable, dependent: :destroy
	
	validates :name, :sku, :description_short, :sale_price, :weight, :height, :width, :depth, :qty_min_in_cart, :qty_max_in_cart, presence: true
	validates :qty_min_in_cart, numericality: {only_integer: true, greater_than: 0}
	validates :sku, uniqueness: true	
	validates :categories, presence: true
	
	default_scope {where(active: true)}

	def to_param
    slug
  end

	def create_slug
    super
  end	
	
	def	capitalized
		super
	end

  def next
    self.class.where("id > ?", id).first
  end

  def prev
    self.class.where("id < ?", id).last
  end	
end
