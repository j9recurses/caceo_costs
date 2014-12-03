class ElectionYearProfilesController < ApplicationController
before_action :get_user


  def election_profile_home
    @profile_years   = ElectionYearProfile.get_all_years(@user)
    @county_name  = CaCountyInfo.where(id: @user[:county]).pluck(:name)
  end

end
