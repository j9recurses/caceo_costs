class ActivitiesController < ApplicationController
  def index
    if params[:day]
      @activities = Activity.sort_by_county_election Activity.since( Time.now.beginning_of_day )
      @title = "Today's Activity"
    elsif params[:week]
      @activities = Activity.sort_by_county_election Activity.since( Time.now.beginning_of_week )
      @title = "This Week's Activity"
    elsif params[:all]
      @activities = Activity.sort_by_county_election Activity.all
      @title = "All open surveys"
    elsif params[:full_report] 
      @reports = Activity.report_all
    end

    respond_to do |format|
      format.html
      format.xlsx { render xlsx: "all-surveys_#{Time.current.strftime('%FT%T%:z')}", template: 'activities/index' }
    end
  end
end