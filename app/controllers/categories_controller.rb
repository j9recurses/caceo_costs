class CategoriesController < ApplicationController

  def index
    @election_year = ElectionYear.find(params[:election_year_id])
    @surveys = CategoryDescription.group(:name, :table_name).order(:cost_type)
    @responses = @surveys.map { |c| 
      klass = c.table_name.singularize.camelize.constantize
      survey = klass.where( county_id: current_user.county_id, election_year_id: params[:election_year_id] ).last
      GeneralSurvey.new( survey )
    }

   session[:election_year] = @election_year.id
  end
end