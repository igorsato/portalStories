class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :access
  has_many :addresses
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :searchable, -> (conditions){where("name like ? OR email like ?", conditions, conditions)}
  before_save :access_default

  accepts_nested_attributes_for :addresses
  
  def access_default
    if self.access.blank?
      self.access = Access.find_by_name('CUSTOMER')
    end
  end
  private 
end
