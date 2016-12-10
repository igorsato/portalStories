class Manage::BaseController < ApplicationController
	layout 'manage/application'
	before_action :check_session
	before_action :authenticate_user!
	# helper_method :current_access
	
	private
	def logged?
		customer_signed_in?
	end
 

  # def after_sign_in_path_for(resource)
	# 	session[:manager] = {"access_id" =>  Access::MANAGER}
  # end
end