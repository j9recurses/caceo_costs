class SurveyResponsesController < ApplicationController
  before_action :new_form, only: [:new, :create]
  before_action :get_form, only: [:edit, :update, :destroy]
  before_action :setup_session, only: [:new, :edit]
  before_action :merge_session, only: [:create, :update]
  before_action :wizard_action, only: [:create, :update]

  def index
    respond_to do |format|
      format.json do
        render json: SurveyResponse.where.not(county_id: 59)
      end
    end  

  end

  def show
    @survey_response = SurveyResponse.includes(:election, :survey, :response).find(params[:id])
    @election = @survey_response.election
    @survey = @survey_response.survey
  end

  def edit
  end

  def create
    puts @response_form.inspect
    puts @survey_response.election.inspect
    if @response_form.model.new_record?
      render :new
    else
      render :edit unless performed?
    end
  end

  def update
    render :edit unless performed?
  end

  def destroy
  end

  private
  def current_resource
    @current_resource ||= SurveyResponse.find(params[:id]) if params[:id]
  end

  def current_session
    params['survey_response']
  end

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
    @response_form.current_step = session[:survey_response][:current_step]
  end

  def setup_session
    session[:survey_response] = {}
  end

  def merge_session
    session[:survey_response].deep_merge!( params[:survey_response] )
  end

  def wizard_action
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
      elsif params[:save_and_exit] || @response_form.last_step?
        if @response_form.submit
          flash['success'] = "Your response has been saved successfully."
          session[:survey_response] = nil
          @response_form.sync
          redirect_to( @response_form.model )
        end
      end
      if session[:survey_response]
        session[:survey_response][:current_step] = @response_form.current_step
      end
    end
    @response_form.sync
  end
end
