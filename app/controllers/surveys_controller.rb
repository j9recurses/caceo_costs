class SurveysController < ApplicationController
  def index
    @election_year = ElectionYear.find(params[:election_year_id])

    @salary_surveys = Survey.where(category: "Salaries")
    @salary_srs = SurveyResponse.where(response_type: @salary_surveys.pluck(:id), 
      county: current_user.county,
      election_id: params[:election_year_id])
    @salary_total = @salary_srs.total
    @salary_hash = @salary_surveys.map do |survey|
      sr = @salary_srs.detect { |sr| sr.response_type == survey.id }
      {survey: survey, survey_response: sr }
    end

    @supply_surveys = Survey.where(category: "Salaries")
    @supply_srs = SurveyResponse.where(response_type: @supply_surveys.pluck(:id), 
      county: current_user.county,
      election_id: params[:election_year_id])
    @supply_total = @supply_srs.total
    @supply_hash = @supply_surveys.map do |survey|
      sr = @salary_srs.detect { |sr| sr.response_type == survey.id }
      {survey: survey, survey_response: sr }
    end

    @srs = SurveyResponse.where(
      county: current_user.county,
      election_id: params[:election_year_id]
      )

   session[:election_id] = params[:election_year_id]
  end

private
  def match_sr(survey, sr_collection)

  end
end
