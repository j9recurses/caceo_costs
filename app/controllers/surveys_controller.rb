class SurveysController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Survey.all }
      format.html do
        @election_year = ElectionYear.find(params[:election_id])

        @salary_surveys = Survey.where(category: "Salaries")
        @salary_srs = SurveyResponse.where(response_type: @salary_surveys.pluck(:id), 
          county: current_user.county,
          election_id: params[:election_id])
        @salary_total = @salary_srs.total
        @salary_hash = @salary_surveys.map do |survey|
          sr = @salary_srs.detect { |sr| sr.response_type == survey.id }
          {survey: survey, survey_response: sr }
        end

        @supply_surveys = Survey.where(category: "Services and Supplies")
        @supply_srs = SurveyResponse.where(response_type: @supply_surveys.pluck(:id), 
          county: current_user.county,
          election_id: params[:election_id])
        @supply_total = @supply_srs.total
        @supply_hash = @supply_surveys.map do |survey|
          sr = @supply_srs.detect { |sr| sr.response_type == survey.id }
          {survey: survey, survey_response: sr }
        end

        @srs = SurveyResponse.where(
          county: current_user.county,
          election_id: params[:election_id])
        session[:election_id] = params[:election_id]
    end
  end
end
