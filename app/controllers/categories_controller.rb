class CategoriesController < ApplicationController

  def index
       # @election_year = ElectionYear.find(params[:election_year_id])
       @county = current_user.county
       # @salary_categories, @salary_total =  Category.get_completed_or_started(params[:election_year_id], @county, "salaries")
       # @supply_categories, @supply_total  =  Category.get_completed_or_started(params[:election_year_id], @county, "services & supplies")
       # @year_total = @salary_total + @supply_total
       #set the election_year session

    # new sheriff in town
    @election_year = ElectionYear.find(params[:election_year_id])
    @surveys = CategoryDescription.group(:name, :model_name).order(:cost_type)
    @responses = @surveys.map { |c| 
      klass = c.model_name.singularize.camelize.constantize
      survey = klass.where( county_id: current_user.county, election_year_id: params[:election_year_id] ).last
      GeneralSurvey.new( survey )
    }

   session[:election_year] = @election_year.id

  end
end

    # @surveys = CategoryDescription.group(:name, :model_name).order(:cost_type)
    # @responses = @surveys.map do |c| 
    #   klass = c.model_name.singularize.camelize.constantize
    #   survey = klass.where( county_id: 1, election_year_id: 11 ).last
    #   GeneralSurvey.new( survey )
    # end