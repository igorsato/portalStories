class NewslettersController < ApplicationController
  def create
    if !params[:newsletter][:name].blank? && !params[:newsletter][:email].blank?
      newsletter = Newsletter.new(newsletter_params)
      if newsletter.save
        redirect_to URI.parse(request.referer).path, notice: 'cadastro realizado com sucesso.'
      end
    end
  end

  private
  def newsletter_params
    params.require(:newsletter).permit(:name, :email)
  end  
end
