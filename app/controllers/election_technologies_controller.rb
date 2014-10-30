class ElectionTechnologiesController < ApplicationController
  before_action :set_election_technology, only: [:show, :edit, :update, :destroy]
  before_action :get_user
  # GET /election_technologies
  # GET /election_technologies.json
  def index
      @county_name  = CaCountyInfo.where(id: @user[:county]).pluck(:name)
  end



    # Never trust parameters from the scary internet, only allow the white list through.
    def election_technology_params
      params[:election_technology]
    end
end
