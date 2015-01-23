class ElectionYearsController < ApplicationController
  def home
    @election_years = ElectionYear.all
  end
end
