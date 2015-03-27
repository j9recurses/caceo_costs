class ElectionYearsController < ApplicationController
  def home
    @election_years = ElectionYear.all
  end

  def index
    @elections = ElectionYear.all
  end
end
