class QuestionsController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: Question.all
      end
    end  
  end
end