class Address < ApplicationRecord
  belongs_to :customer
  has_many :orders
  belongs_to :state
  validates :alias, :street, :number, :postal_code, :neighborhood, presence: true
  after_save :main
  after_destroy :verify_main, :set_main
  
  def main
    if self.main_address
      self.class.where(customer: self.customer).where.not(id: self.id).update_all(main_address: false)
    else
      if self.class.where(customer: self.customer).count == 1
        self.class.where(id: self.id).update({main_address: true})   
      end     
    end
  end
  def set_main
    if self.class.where(main_address: true, customer: self.customer).blank? && self.class.where(main_address: false, customer: self.customer).count > 1
      self.class.where(customer: self.customer).first.update({main_address: true})
    end
  end
  def verify_main
    if self.class.where(customer: self.customer).count == 1
      self.class.where(customer: self.customer).update({main_address: true})
    end         
  end
end
