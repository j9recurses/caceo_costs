class GeneralSurveysController < ApplicationController
  before_action :election_profile_session
  before_action :require_election
  before_action :survey_from_record_id, only: [:show, :edit, :update, :destroy]
  before_action :merge_session

  # show action (implicit)

  def new
    @survey = GeneralSurvey.new( klass.new )
    @survey.election = session_election
    session[session_model_params] = {}
    render :new
  end

  def edit
    session[session_model_params] = {}
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
      redirect_to election_year_categories_path(session[:election_year])
    end
  end

private
  def wizard_action
    if election_profiles_controller?
      @survey.data.assign_attributes( survey_session )
      if @survey.data.valid?
        if params[:back_button]
          @survey.data.step_back
        elsif params[:next_button]
          @survey.data.step_forward  
        elsif params[:save_and_continue]
          if ResponsePersistor.new( @survey.data ).save
            flash.now['success'] = "Your progress has been saved."
            @survey.data.step_forward
          end      
        elsif params[:save_and_exit] || @survey.data.last_step?
          if ResponsePersistor.new( @survey.data ).save
            flash['success'] = flash_message
            survey_session = nil
            redirect_to( @survey.data )
          end
        end
        survey_session[:current_step] = @survey.data.current_step if survey_session
      end
    else
      session[session_model_params] ||= {}
      session[session_model_params].deep_merge!(params[model_singular]) if params[model_singular]
      @survey.data.assign_attributes( session[session_model_params] )
      if @survey.data.valid?
        if params[:back_button]
          @survey.data.step_back
        elsif params[:next_button]
          @survey.data.step_forward  
        elsif params[:save_and_continue]
          if ResponsePersistor.new( @survey.data ).save
            flash.now['success'] = "Your progress has been saved."
            @survey.data.step_forward
          end      
        elsif params[:save_and_exit] || @survey.data.last_step?
          if ResponsePersistor.new( @survey.data ).save
            flash['success'] = flash_message
            session[session_model_params] = nil
            redirect_to( @survey.data )
          end
          session[session_model_params][:current_step] = @survey.data.current_step if session[session_model_params]
        end
      end
    end
  end

  def merge_session
    if election_profiles_controller?
      survey_session ||= {}
      survey_session = SurveyNa.new( survey_session, params[model_singular] ).merged_session
    end
  end

  # for permissions
  def current_resource
    @current_resource = klass.find(params[:id]) if params[:id]
  end

  # for permissions
  def current_session
    params[model_singular]
  end

  def survey_session
    session[session_model_params]
  end
  helper_method :survey_session

  def survey_from_record_id
    @survey = GeneralSurvey.new( klass.find(params[:id]) )
  end

  def table_name
    @table_name ||= self.class.to_s.gsub('Controller', '').underscore
  end

  def model_singular
    @model_singular ||= table_name.singularize
  end

  def session_model_params
    @session_model_params ||= "#{model_singular}_params"
  end

  def klass
    @klass ||= table_name.singularize.camelize.constantize
  end

  # Methods below know Election Profiles exist
  def election_profiles_controller?
    table_name == 'election_profiles'
  end

  def election_profile_session
    if election_profiles_controller? && params[:election_year_profile_id]
      session[:election_year_profile] = params[:election_year_profile_id]
    end
  end

  def session_election
    if election_profiles_controller?
      session[:election_year_profile]
    else
      session[:election_year]
    end
  end
  helper_method :session_election

  def election_year_home_path
    if election_profiles_controller?
      election_profile_home_path
    else
      home_path
    end
  end

  def flash_message
    if self.action_name == 'create'
      action_msg = 'Successfully Saved'
    elsif self.action_name == 'update'
      action_msg = 'Successfully Updated'
    end

    if election_profiles_controller?
      msg = "#{action_msg} Election Profile Information for the #{@survey.election.year}"
    else
      msg = "#{action_msg} #{view_context.format_survey_label @survey.name} Costs for the #{@survey.election.year}"
    end
  end

  def require_election
    unless session_election
      redirect_to election_year_home_path
    end
  end
end