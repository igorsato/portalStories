class Access < ApplicationRecord
  has_one :customer
  
  ADMIN = Access.find_by_name('ADMIN')
  MANAGER = Access.find_by_name('MANAGER')
  CUSTOMER = Access.find_by_name('CUSTOMER')

  cattr_accessor :admin do
    [
      ADMIN, MANAGER
    ]
  end

  def admin?
    admin.include?(self)
  end

  def customer?
    self == CUSTOMER
  end

  def manager?
    self == MANAGER
  end
end