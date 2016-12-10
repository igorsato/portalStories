class Category < ApplicationRecord
	before_save :create_slug, :capitalized

	has_and_belongs_to_many :products, join_table: :categories_has_products, uniq: true, dependent: :destroy
	validates :name, presence: true, uniqueness: true
	scope :searchable, ->(conditions){where("name LIKE ?", "%#{conditions}%")}
	def to_param
    slug
  end
	def create_slug
    super
  end	

	def	capitalized
		super
	end

	def destroy
		if !products.present?
			super
		end
	end
end
