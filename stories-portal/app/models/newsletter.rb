class Newsletter < ApplicationRecord
  validates :email, uniqueness: true
  before_save :active
  
  def active
    self.active = true
  end
end
