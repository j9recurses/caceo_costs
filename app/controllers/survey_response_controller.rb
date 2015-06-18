class SurveyResponseController < ApplicationController
  before_action :new_form, only: [:new, :create]
  before_action :get_form, only: [:edit, :update, :destroy]
  before_action :setup_session, only: [:new, :edit]
  before_action :merge_session, only: [:create, :update]
  before_action :wizard_action, only: [:create, :update]

private

  def new_form
    @response_form = SurveyResponseForm.new(
      SurveyResponse.new( county_id: session[:county_id], election_id: session[:election_id] ),
      params[:response_type].constantize.new)
  end

  def get_form
    @response_form = SurveyResponseForm.new( SurveyResponse.find params[:id] )
  end

  def setup_session
    session[:response_form] = {}
  end

  def merge_session
    session[:response_form].deep_merge!( params[:response_form] )
  end

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
        if @response_form.submit
          flash['success'] = "Your response has been saved successfully."
          session[:response_form] = nil
          redirect_to( @response_form.survey_response )
        end
      end
      if session[:response_form]
        session[:response_form][:current_step] = @response_form.pages.current_step
      end
    end
  end
end
