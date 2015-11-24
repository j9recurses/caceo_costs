class ElectionsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Election.all, each_serializer: ElectionSerializer }
      format.html { @elections = Election.all }
    end  
  end
end
