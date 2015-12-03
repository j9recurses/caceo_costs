class SurveyResponsesController < ApplicationController
  before_action :new_form, only: [:new, :create]
  before_action :get_form, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.json do
        render json: SurveyResponse.where.not(county_id: 59)
      end
      format.html do
        if session[:election_id]
          redirect_to election_surveys_path(session[:election_id])
        else
          redirect_to elections_path
        end
      end
    end
  end

  def show
    @survey_response = SurveyResponse.includes(:election, :survey, :response).find(params[:id])
    @election = @survey_response.election
    @survey = @survey_response.survey
  end

  def new
    session[:survey_response] = {}
  end

  def edit
    session[:survey_response] = {}
  end

  def create
    wizard_action
    if @sr_form.model.new_record?
      render :new
    else
      render :edit unless performed?
    end
  end

  def update
    wizard_action
    render :edit unless performed?
  end

  def destroy
    @sr_form.destroy
    redirect_to election_surveys_path(session[:election_id])
  end

  private

  def new_form
    @response = params[:survey_id].constantize.new
    @survey_response = SurveyResponse.new( 
      county_id:        params[:county_id], 
      election_id:      params[:election_id],
      response:         @response )
    @sr_form = SurveyResponseForm.new @survey_response
    @survey = @survey_response.survey
    @sr_form.current_step = session[:survey_response][:current_step] if session[:survey_response]
  end

  def get_form
    @survey_response = SurveyResponse.find params[:id]
    @sr_form = SurveyResponseForm.new @survey_response
    @survey = @survey_response.survey
    @sr_form.current_step = session[:survey_response][:current_step] if session[:survey_response]
  end

  def wizard_action
    session[:survey_response] ||= {}
    session[:survey_response].deep_merge!( params[:survey_response] ) if params[:survey_response]
    if @sr_form.validate( session[:survey_response] )
      if params[:back_button]
        @sr_form.step_back
      elsif params[:next_button]
        @sr_form.step_forward
      elsif params[:save_and_continue]
        if @sr_form.submit
          flash.now['success'] = "Your progress has been saved."
          @sr_form.step_forward
        end
      elsif params[:save_and_exit] || @sr_form.last_step? || params[:commit]
        if @sr_form.submit
          flash['success'] = "Your response has been saved successfully."
          session[:survey_response] = nil
          redirect_to( @sr_form.model )
        end
      elsif params[:empty_na]
        if @sr_form.empty_na.submit
          flash['success'] = "Your response has been updated with N/A values."
          session[:survey_response] = nil
          redirect_to( @sr_form.model )
        end
      end
      if session[:survey_response]
        session[:survey_response][:current_step] = @sr_form.current_step
      end
    end
    @sr_form.sync
  end

  # if there is no id, there's an action on an unsaved record b/c wizard
  def current_resource
    @current_resource ||= if params[:id]
      SurveyResponse.find(params[:id])
    else
      params['survey_response']
    end
  end
end
