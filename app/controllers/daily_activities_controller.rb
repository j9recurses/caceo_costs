class DailyActivitiesController < ApplicationController
  before_action :set_daily_activity, only: [:show, :edit, :update, :destroy]

  # GET /daily_activities
  # GET /daily_activities.json
  def index
    @daily_activities = DailyActivity.county_surveys
  end

  # GET /daily_activities/1
  # GET /daily_activities/1.json
  # def show
  # end

  # GET /daily_activities/new
  # def new
  #   @daily_activity = DailyActivity.new
  # end

  # GET /daily_activities/1/edit
  # def edit
  # end

  # POST /daily_activities
  # POST /daily_activities.json
  # def create
  #   @daily_activity = DailyActivity.new(daily_activity_params)

  #   respond_to do |format|
  #     if @daily_activity.save
  #       format.html { redirect_to @daily_activity, notice: 'Daily activity was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @daily_activity }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @daily_activity.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /daily_activities/1
  # PATCH/PUT /daily_activities/1.json
  # def update
  #   respond_to do |format|
  #     if @daily_activity.update(daily_activity_params)
  #       format.html { redirect_to @daily_activity, notice: 'Daily activity was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @daily_activity.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /daily_activities/1
  # DELETE /daily_activities/1.json
  # def destroy
  #   @daily_activity.destroy
  #   respond_to do |format|
  #     format.html { redirect_to daily_activities_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_daily_activity
    #   @daily_activity = DailyActivity.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def daily_activity_params
    #   params[:daily_activity]
    # end
end
