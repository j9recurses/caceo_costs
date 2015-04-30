class ElectionYearProfilesController < ApplicationController
  def election_profile_home
    @election_years = ElectionYear.all
  end
end
