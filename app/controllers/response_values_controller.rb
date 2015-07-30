class ResponseValuesController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: ResponseValue.joins(:survey_response).where('NOT(survey_responses.county_id = 59)')
      end
    end  
  end
end