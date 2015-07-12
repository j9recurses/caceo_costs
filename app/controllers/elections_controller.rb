class ElectionsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: ElectionYear.all }
      format.html { @elections = ElectionYear.all }
    end  
  end
end
