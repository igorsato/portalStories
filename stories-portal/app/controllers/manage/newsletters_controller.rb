class Manage::NewslettersController  < Manage::BaseController
  def index
    @newsletters = Newsletter.all
  end
end
