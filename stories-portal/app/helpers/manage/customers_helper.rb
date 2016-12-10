module Manage::CustomersHelper
  def access_type(type)
    access_type = {CUSTOMER: 'CLIENTE', ADMIN: 'ADMINISTRADOR', MANAGER: 'GERENTE'}
    access_type[type.to_sym]
  end
end
