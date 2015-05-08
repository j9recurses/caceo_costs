class SurveyResponseController < ApplicationController
  before_action :new_form, only: [:new, :create]
  before_action :get_form, only: [:edit, :update, :destroy]
  before_action :setup_session, only: [:new, :edit]
  before_action :merge_session, only: [:create, :update]
  before_action :wizard_action, only: [:create, :update]

private

  def new_form
    @response_form = ResponseForm.new(
      SurveyResponse.new( county_id: session[:county_id], election_id: session[:election_id] ),
      params[:response_type].constantize.new
      )
  end

  def get_form
    @response_form = ResponseForm.new(
      SurveyResponse.find params[:id]
      )
  end

  # def get_survey_response
  #   @survey_response = SurveyResponse.find(params[:id])
  #   @response = @survey_response.response
  #   @survey = @survey_response.survey
  # end

  # def new_survey_response
  #   # survey_id?
  #   @response = params[:response_type].constantize.new
  #   @survey_response = SurveyResponse.new(
  #     county_id:   session[:county_id], 
  #     election_id: session[:election_id],
  #     response: @response
  #     )
  #   @survey = @survey_response.survey
  # end

  def setup_session
    session[:response] = {}
  end

  def merge_session
    session[:response].deep_merge!( params[:response] )
  end

  # def wizard_action
  #   @response.assign_attributes( session[:response] )
  #   if @response.valid?
  #     if params[:back_button]
  #       @response.step_back
  #     elsif params[:next_button]
  #       @response.step_forward  
  #     elsif params[:save_and_continue]
  #       if SurveyResponsePersistor.new( @survey_response ).save
  #         flash.now['success'] = "Your progress has been saved."
  #         @response.step_forward
  #       end      
  #     elsif params[:save_and_exit] || @response.last_step?
  #       if SurveyResponsePersistor.new( @survey_response ).save
  #         flash['success'] = "Your response has saved successfully."
  #         survey_session = nil
  #         redirect_to( @response.survey_response )
  #       end
  #     end
  #     session[:response][:current_step] = @response.current_step if session[:response]
  #   end
  # end

  def wizard_action
    @response_form.enter( session[:response_form] )
    if @response_form.valid?
      if params[:back_button]
        @response_form.pages.step_back
      elsif params[:next_button]
        @response_form.pages.step_forward  
      elsif params[:save_and_continue]
        if @response_form.submit
          flash.now['success'] = "Your progress has been saved."
          @response_form.pages.step_forward
        end      
      elsif params[:save_and_exit] || @response_form.pages.last_step?
        if SurveyResponsePersistor.new( @survey_response ).save
          flash['success'] = "Your response has saved successfully."
          survey_session = nil
          redirect_to( @response_form.survey_response )
        end
      end
      session[:current_step] = @response_form.pages.current_step
    end
  end

end
