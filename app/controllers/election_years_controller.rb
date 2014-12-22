class ElectionYearsController < ApplicationController
before_action :get_user
before_action :set_election_year, only: [:view_year]

  def home
    @years, @total_election_year_costs  = ElectionYear.get_all_years(@user)
    @county_name  = current_user.county.name
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_election_year
    @election_year = ElectionYear.find(params[:id])
  end
end
