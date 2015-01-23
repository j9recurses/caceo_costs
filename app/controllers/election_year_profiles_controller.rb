class ElectionYearProfilesController < ApplicationController
  def election_profile_home
    @election_years = ElectionYearProfile.all.county_profile( current_user.county_id )
  end
end
