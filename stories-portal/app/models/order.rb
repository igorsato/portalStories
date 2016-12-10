class Order < ApplicationRecord
  belongs_to :payment
  belongs_to :customer
  belongs_to :order_status
  has_many :order_items
  belongs_to :address
  before_create :set_order_status
  before_save :update_sub_total, :set_total
  def sub_total
    order_items.collect{|item| item.valid? ? (item.quantity * item.unit_price) : 0}.sum
  end

  def final_total
    sub_total + self.shipping.to_s.to_d
  end

  private
  def set_total
    self.total = final_total
  end
  def set_order_status
    self.order_status_id = 1
  end
  
  def update_sub_total
    self[:subtotal] = sub_total
  end
end
