class ElectionsController < ApplicationController
  def index
    @elections = ElectionYear.all
  end
end
