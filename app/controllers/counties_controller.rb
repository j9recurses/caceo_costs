class CountiesController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: County.all
      end
    end  
  end
end