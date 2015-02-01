class ElectionYearProfilesController < ApplicationController
  def election_profile_home
    @election_years = ElectionYearProfile.all
  end
end
