class GeneralSurveysController < ApplicationController
  before_action :election_profile_session, only: :index
  before_action :require_election
  before_action :survey_from_record_id, only: [:show, :edit, :update, :destroy]

  def index
    if election_profiles_controller?
      surv_status = ElectionProfile.find_by(county: current_user[:county], election_year_profile_id: params[:election_year_profile_id])
      id = surv_status.id if surv_status
    else
      surv_status = Category.find_by(election_year_id: session[:election_year], county: current_user[:county],  model_name: model_name)
      id = klass.where(county: current_user[:county], election_year_id: session[:election_year]).pluck(:id).last
    end

    if surv_status && surv_status.started?
      redirect_to send("#{model_singular}_path", id)
    else
      redirect_to send("new_#{model_singular}_path")
    end
  end

  def show
    render file: "#{ Rails.root.join('app/views/general_surveys/show') }"
  end

  def new
    @survey = GeneralSurvey.new( klass.new )
    @survey.election = session_election
    session[session_model_params] = {}
    render file: "#{ Rails.root.join('app/views/general_surveys/new') }"
  end

  def edit
    session[session_model_params] = {}
    render file: "#{ Rails.root.join('app/views/general_surveys/edit') }"
  end

  def create
    @survey = GeneralSurvey.new( klass.new )
    wizard_action
    if @survey.data.new_record?
      render file: "#{ Rails.root.join('app/views/general_surveys/new') }"
    else
      render file: "#{ Rails.root.join('app/views/general_surveys/edit') }" unless performed?
    end
  end

  def update
    wizard_action
    render file: "#{ Rails.root.join('app/views/general_surveys/edit') }" unless performed?
  end

  def destroy
    SurveyPersistor.new( @survey ).destroy
    redirect_to send("#{model_name}_path")
  end

private
  def wizard_action
    session[session_model_params] ||= {}
    session[session_model_params].deep_merge!(params[model_singular]) if params[model_singular]
    @survey.data.assign_attributes( session[session_model_params] )
    if @survey.data.valid?
      if params[:back_button]
        @survey.data.step_back
      elsif params[:next_button]
        @survey.data.step_forward  
      elsif params[:save_and_continue]
        if SurveyPersistor.new( @survey ).save
          flash.now[:notice] = "Your progress has been saved."
          @survey.data.step_forward
        end      
      elsif params[:save_and_exit] || @survey.data.last_step?
        if SurveyPersistor.new( @survey ).save
          flash[:notice] = flash_message
          session[session_model_params] = nil
          redirect_to @survey.data
        end
      end
      session[session_model_params][:current_step] = @survey.data.current_step if session[session_model_params] 
    end
  end

  # def require_session
  #   unless session[session_model_params]
  #     puts 'this is happening THIS IS HAPPENING'
  #     flash[:error] = "Your session has expired. To continue working on this survey, please click the EDIT link."
  #     redirect_to action: :index
  #   end
  # end

  def current_resource
    @current_resource = klass.find(params[:id]) if params[:id]
  end

  def current_session
    params[model_singular]
  end

  def survey_from_record_id
    @survey = GeneralSurvey.new( klass.find(params[:id]) )
  end

  def model_name
    @model_name ||= self.class.to_s.gsub('Controller', '').underscore
  end

  def model_singular
    @model_singular ||= model_name.singularize
  end

  def session_model_params
    @session_model_params ||= "#{model_singular}_params"
  end

  def klass
    @klass ||= model_name.singularize.camelize.constantize
  end

 # Methods below know Election Profiles exist
  
  def election_profiles_controller?
    model_name == 'election_profiles'
  end

  def election_profile_session
    session[:election_year_profile] = params[:election_year_profile_id]
  end

  def session_election
    if election_profiles_controller?
      session[:election_year_profile]
    else
      session[:election_year]
    end
  end
  helper_method :session_election

  def flash_message
    if self.action_name == 'create'
      action_msg = 'Successfully Saved'
    elsif self.action_name == 'update'
      action_msg = 'Successfully Updated'
    end

    if election_profiles_controller?
      msg = "#{action_msg} Election Profile Information for the #{@survey.election.year}"
    else
      msg = "#{action_msg} #{view_context.format_survey_label @survey.category.name} Costs for the #{@survey.election.year}"
    end
  end

  def require_election
    unless session_election
      if election_profiles_controller?
        redirect_to election_profile_home_path
      else
        redirect_to home_path
      end
    end
  end


end

# class ElectionProfilesController < ApplicationController

# before_action :get_user, :get_model_name
# before_action :get_election_profile_description, :make_chunks,  except: [:destroy]
# before_action :load_product, :set_election_profile, only: [:show, :update, :edit, :destroy]

# before_action :set_session_election_year_profile_index, only: [:index]
# before_action :get_session_election_year_profile, only: [:create, :update, :show, :new, :edit]

# def index
#   @election_profile_stuff = ElectionProfile.where(county: @user[:county], election_year_profile_id: params[:election_year_profile_id]).pluck(:id)
#   if @election_profile_stuff.size == 0
#      redirect_to new_election_profile_path(params[:election_year_profile_id])
#   else
#     redirect_to election_profile_path(@election_profile_stuff)
#   end
# end

#  def show
#     @election_profile = ElectionProfile.find(params[:id])
#   end

#   def new
#      @election_profile = @wizard.object
#   end

#   def edit
#   end

#   def create
#     @election_profile = @wizard.object
#     if @wizard.save
#         ElectionProfile.category_status(@election_profile[:id], @election_profile)
#         redirect_to @election_profile, notice: "The  Election Profile Information for the " + @election_year_profile[:year] + " That You Entered Was Successfully Updated"
#       else
#         render :new
#        end
#     end

#   def update
#      if @wizard.save
#       ElectionProfile.category_status( @election_profile[:id], @election_profile)
#       redirect_to @election_profile, notice: "The  Election Profile Information for the "  + @election_year_profile[:year] + "That You Entered Was Successfully Updated"
#     else
#       render action: 'edit'
#     end
#   end

#     def destroy
#     @election_profile.destroy
#     redirect_to election_profiles_path(:election_year_profile_id => @election_profile[:election_year_profile_id]  )
#   end