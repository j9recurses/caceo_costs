class GeneralSurveysController < ApplicationController
  before_action :election_profile_session
  before_action :require_election
  before_action :survey_from_record_id, only: [:show, :edit, :update, :destroy]
  # before_action :merge_session

  # show action (implicit)

  def new
    @survey = GeneralSurvey.new( klass.new )
    @survey.data.election_year_id = session[:election_id]
    response_session = {}
    render :new
  end

  def edit
    response_session = {}
    render :edit
  end

  def create
    @survey = GeneralSurvey.new( klass.new )
    wizard_action
    if @survey.data.new_record?
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
    ResponsePersistor.new( @survey.data ).destroy
    if election_profiles_controller?
      redirect_to election_profile_home_path
    else
      redirect_to election_year_categories_path(session[:election_id])
    end
  end

private
  def wizard_action
    response_session ||= {}
    response_session.deep_merge!( response_params ) if response_params
    @survey.data.assign_attributes( response_session )
    if @survey.data.valid?
      if params[:back_button]
        @survey.data.step_back
      elsif params[:next_button]
        @survey.data.step_forward  
      elsif params[:save_and_continue]
        if ResponsePersistor.new( @survey.data ).submit
          flash.now['success'] = "Your progress has been saved."
          @survey.data.step_forward
        end      
      elsif params[:save_and_exit] || @survey.data.last_step?
        if ResponsePersistor.new( @survey.data ).submit
          flash['success'] = flash_message
          flash['success'] = "Your response has saved successfully."
          response_session = nil
          redirect_to( @survey.data )
        end
        response_session[:current_step] = @survey.data.current_step if response_session
      end
    end
  end

  # for permissions
  def current_resource
    @current_resource = klass.find(params[:id]) if params[:id]
  end

  # for permissions
  def current_session
    params[model_name]
  end

  def response_params
    params[model_name]
  end

  def response_session
    session["#{model_name}_params"]
  end
  helper_method :survey_session

  def survey_from_record_id
    @survey = GeneralSurvey.new( klass.find(params[:id]) )
  end

  def model_name
    @model_name ||= self.class.to_s.gsub('Controller', '').underscore.singularize
  end

  def klass
    @klass ||= model_name.camelize.constantize
  end

  # Methods below know Election Profiles exist
  def election_profiles_controller?
    model_name == 'election_profile'
  end

  def election_profile_session
    if election_profiles_controller? && params[:election_year_id]
      session[:election_id] = params[:election_year_id]
    end
  end

  def election_year_home_path
    if election_profiles_controller?
      election_profile_home_path
    else
      home_path
    end
  end

  def require_election
    unless session[:election_id]
      redirect_to election_year_home_path
    end
  end
end