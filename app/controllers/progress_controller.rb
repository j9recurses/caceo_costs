class ProgressController < ApplicationController

  def index
    @progress_array = SurveyResponseReport.progress_array
    respond_to do |format|
      format.xlsx do
        render xlsx: "progress_#{Time.current.strftime('%FT%T%:z')}", 
        template: 'reports/progress'
      end

      format.html do
        @counties = County.where.not(id: 59)
      end
    end  
  end

  def show
    if params[:election_id]
      @county   = County.find(params[:county_id])
      @election = ElectionYear.find(params[:election_id])
      @surveys  = Survey.all
      render :show_election
    else
      @county = County.find(params[:id])
      @elections = ElectionYear.all
    end
  end

end
