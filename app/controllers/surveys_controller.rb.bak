class SurveysController < ApplicationController
  def index
    @election_year = ElectionYear.find(params[:election_year_id])

    @salary_surveys = Survey.where(category: "Salaries")
    @salary_srs = @salary_surveys.map do |s|
      r = s.survey_responses.where(county: current_user.county, election_id: params[:election_year_id])
    end

    @supply_surveys = Survey.where(category: "Services and Supplies")
    @supply_srs = @supply_surveys.map do |s|
      r = s.survey_responses.where(county: current_user.county, election_id: params[:election_year_id])
    end

   session[:election_id] = params[:election_year_id]
  end
end
