class ActivitiesController < ApplicationController
  def index
    @activities = Activity.all
  end

  def summary
    @day_activity = Activity.today
    @week_activity = Activity.last_week
    @month_activity = Activity.last_month

    @day_time = Activity.day_begin
    @week_time = Activity.week_begin
    @month_time = Activity.month_begin
  end

  def earlier
    @earlier_activity = Activity.all_prior

    @month_time = Activity.month_begin
    @oldest_update = SurveyResponse.minimum(:updated_at)
  end
end