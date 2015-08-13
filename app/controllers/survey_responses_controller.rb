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
    if @response_form.model.new_record?
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
    @response_form.destroy
    redirect_to election_surveys_path(session[:election_id])
  end

  private

  def new_form
    @response = params[:survey_id].constantize.new(
      county_id:        params[:county_id], 
      election_year_id: params[:election_id] )
    @survey_response = SurveyResponse.new( 
      county_id:        params[:county_id], 
      election_id:      params[:election_id],
      response:         @response )
    @response_form = SurveyResponseForm.new @survey_response
    @survey = @survey_response.survey
  end

  def get_form
    @survey_response = SurveyResponse.find params[:id]
    @response_form = SurveyResponseForm.new @survey_response
    @survey = @survey_response.survey
    @response_form.current_step = session[:survey_response][:current_step] if session[:survey_response]
  end

  def wizard_action
    session[:survey_response] ||= {}
    session[:survey_response].deep_merge!( params[:survey_response] ) if params[:survey_response]
    if @response_form.validate( session[:survey_response] )
      if params[:back_button]
        @response_form.step_back
      elsif params[:next_button]
        @response_form.step_forward
      elsif params[:save_and_continue]
        if @response_form.submit
          flash.now['success'] = "Your progress has been saved."
          @response_form.step_forward
        end
      elsif params[:save_and_exit] || @response_form.last_step? || params[:commit]
        if @response_form.submit
          flash['success'] = "Your response has been saved successfully."
          session[:survey_response] = nil
          redirect_to( @response_form.model )
        end
      elsif params[:empty_na]
        if @response_form.empty_na.submit
          flash['success'] = "Your response has been updated with N/A values."
          session[:survey_response] = nil
          redirect_to( @response_form.model )
        end
      end
      if session[:survey_response]
        session[:survey_response][:current_step] = @response_form.current_step
      end
    end
    @response_form.sync
  end

  def current_resource
    @current_resource ||= SurveyResponse.find(params[:id]) if params[:id]
  end

  def current_session
    params['survey_response']
  end
end
