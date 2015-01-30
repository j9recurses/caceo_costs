class ElectionYearsController < ApplicationController
  def home
    @election_years = ElectionYear.all
    flash.now[:notice] = "Surveys for the 2014 General Election are temporarily unavailable, please check back later today to find them. Thanks!"
  end
end
