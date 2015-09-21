require 'csv'
require 'tech_serializer'

class DataController < ActionController::Base
  def index
    respond_to do |format|
      format.json do
        render json: ResponseValue.limit(100), each_serializer: DataSerializer
      end

      format.csv do
        if params[:date]
          year = params[:date].slice(0,4).to_i
          month = params[:date].slice(4,2).to_i
          day = params[:date].slice(6,2).to_i
          date = Date.new(year, month, day)
          rv_date_query = ['DATE(response_values.updated_at) <= ?', date]
          tech_date_query = ['DATE(updated_at) <= ?', date]
        else
          rv_date_query = tech_date_query = nil
        end

        headers["Content-Dispostion"] = %Q{attachment; filename="data-#{Time.current.strftime("%FT%T%:z")}.csv"}
        self.response_body = Enumerator.new do |response|
          csv = CSV.new(response, row_sep: "\n")
          csv << %w[CountyId Election Survey Question Value]

            # .select(<<-SQL
            #   response_values.*,
            #   survey_responses.county_id AS county_id,
            #   survey_responses.response_type AS survey_code,
            #   election_years.code AS election_code,
            #   questions.field AS field
            # SQL
            # )
            # .references(:survey_response, :election, :question)            

          ResponseValue.includes(:survey_response, :election, :question, :survey)
            .where.not(survey_responses: {county_id: 59})
            .where(rv_date_query)
            .find_each do |rv|
              csv << [
                rv.survey_response.county_id,
                rv.election.code,
                rv.survey.id,
                rv.question.field,
                rv.data_value]
          end

          [TechVotingMachine, TechVotingSoftware].each do |tech_klass|
            TechSerializer.new(tech_klass, tech_date_query).each do |trv|
              csv << [
                trv.county_id,
                trv.election_code,
                trv.survey_code,
                trv.field,
                trv.value
              ]
            end
          end
        end
      end
    end
  end
end
