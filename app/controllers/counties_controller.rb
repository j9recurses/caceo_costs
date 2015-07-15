class CountiesController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: County.where.not(id: 59)
      end
    end  
  end
end