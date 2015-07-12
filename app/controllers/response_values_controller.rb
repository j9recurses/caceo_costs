class ResponseValuesController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: ResponseValue.all
      end
    end  
  end
end