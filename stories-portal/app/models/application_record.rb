class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

	def create_slug
    self.slug = self.name.parameterize
  end	

	def	capitalized
		self.name = self.name.split(' ').map(&:capitalize).join(' ')
	end

end
