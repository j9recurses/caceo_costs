require 'csv'

class DataController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: ResponseValue.limit(100), each_serializer: DataSerializer
      end

      format.csv do
        headers["Content-Dispostion"] = %Q{attachment; filename="data-#{Time.current.strftime("%FT%T%:z")}.csv"}
        self.response_body = Enumerator.new do |response|
          csv = CSV.new(response, row_sep: "\n")
          csv << %w[CountyId Election Survey Question Value]
          ResponseValue.joins(:survey_response)
            .where.not(survey_responses: {county_id: 59})
            .find_each do |rv|
              csv << [
                rv.survey_response.county_id,
                rv.survey_response.election.code,
                rv.survey_response.response_type,
                rv.question.field,
                rv.data_value]
          end
        end
      end
    end
  end
end
