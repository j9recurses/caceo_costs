class CategoriesController < ApplicationController

  def index
    @election_year = ElectionYear.find(params[:election_year_id])

    @salary_surveys = Survey.where(category: "Salaries")
    @salary_responses = @salary_surveys.map do |s|
      r = s.responses.find_or_initialize_by(county: current_user.county, election_year_id: params[:election_year_id])
      GeneralSurvey.new( r )
    end
    @salary_srs = @salary_surveys.map do |s|
      r = s.survey_responses.where(county: current_user.county, election_id: params[:election_year_id])
    end

    @supply_surveys = Survey.where(category: "Services and Supplies")
    @supply_srs = @supply_surveys.map do |s|
      r = s.survey_responses.where(county: current_user.county, election_id: params[:election_year_id])
    end

    @supply_responses = @supply_surveys.map do |s|
      r = s.responses.find_or_initialize_by(county: current_user.county, election_year_id: params[:election_year_id])
      GeneralSurvey.new( r )
    end

   session[:election_id] = params[:election_year_id]
  end
end
