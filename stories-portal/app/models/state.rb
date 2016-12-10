class State < ApplicationRecord
  has_many :addresses

  def full_name
    "#{self.unit}"
  end
end
