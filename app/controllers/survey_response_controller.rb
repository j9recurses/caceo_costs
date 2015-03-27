class SurveyResponseController < ApplicationController
  before_action :merge_session
  before_action :session_response_form
  # , only: [:new, :create, :show, :edit, :update]
  # before_action :find_survey_response_form, only: [:show, :edit, :update]
  # def index
  # end

  def merge_session
    session[:response_form].deep_merge!(params[:response_form])
  end

  def session_response_form
    @response_form = ResponseForm.new( session[:response_form] )
  end

  # def session_response_form
  #   @response_form = ResponseForm.new(
  #     SurveyResponse.new(
  #     county_id:   session[:county_id],
  #     election_id: session[:election_id],
  #     survey_id:   session[:survey_id]
  #     )
  #   )
  # end

  # def find_survey_response_form
  #   @response_form = ResponseForm.new( SurveyResponse.find params[:id] )
  # end

  def create
    wizard_action
  end

  def update
    wizard_action
  end
private

  # session[session_model_params] ||= {}
  # session[session_model_params].deep_merge!(params[model_singular]) if params[model_singular]


  def wizard_action
    @response_form.assign_attributes( merged_session )
    if @response_form.valid?
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
          flash['success'] = flash_message
          survey_session = nil
          redirect_to( @response_form.survey_response )
        end
      end
      survey_session[:current_step] = @response_form.current_step if survey_session
    end
  end
end
