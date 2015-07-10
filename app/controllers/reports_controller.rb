class ReportsController < ApplicationController
  def progress
    @progress_array = SurveyResponseReport.progress_array
    respond_to do |format|
      format.xlsx do
        render xlsx: "progress_#{Time.current.strftime('%FT%T%:z')}", 
        template: 'reports/progress'
      end
    end  
  end

  def responses
    @responses_array = ResponseValueReport.responses_array
    @questions = ResponseValueReport.question_metadata_hash
    @tech_responses_array = ResponseValueReport.tech_responses_array
    respond_to do |format|
      format.xlsx do
        render xlsx: "responses_#{Time.current.strftime('%FT%T%:z')}", 
        template: 'reports/responses'
      end
    end  
  end
end
