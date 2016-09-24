class ElectionsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: Election.all, each_serializer: ElectionSerializer }
      format.html { @elections = Election.all }
    end  
  end

  def show
    respond_to do |format|
      @county_survey_responses = SurveyResponse.where(
        county_id: current_user.county_id,
        election_id: params[:id]
      )
      @election = Election.find(params[:id])

      format.xlsx do
        render xlsx: "#{
          current_user.county.name.gsub(' County', '')}_#{
          @election.code}_Responses_#{
          Time.current.strftime('%F')}", 
        template: 'elections/show'
      end
    end
  end
end
