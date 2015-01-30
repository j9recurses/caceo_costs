class ElectionYearProfilesController < ApplicationController
  def election_profile_home
    @election_years = ElectionYearProfile.all
    flash.now[:notice] = "Surveys for the 2014 General Election are temporarily unavailable, please check back later today to find them. Thanks!"

  end
end
