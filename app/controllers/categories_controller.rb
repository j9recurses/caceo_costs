class CategoriesController < ApplicationController

  def index
       @election_year = ElectionYear.find(params[:election_year_id])
       @county = current_user.county
       @salary_categories, @salary_total =  Category.get_completed_or_started(params[:election_year_id], @county, "salaries")
       @supply_categories, @supply_total  =  Category.get_completed_or_started(params[:election_year_id], @county, "services & supplies")
       @year_total = @salary_total + @supply_total
       #set the election_year session
       session[:election_year] = @election_year.id
  end
end
