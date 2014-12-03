class GeneralSurveysController < ApplicationController
  before_action :require_election
  before_action :survey_from_record_id, only: [:show, :edit, :update, :destroy]

  def index
    @category= Category.find_by(election_year_id: session[:election_year], county: current_user[:county],  model_name: model_name)
    if @category.started == true

      id = klass.where(county: current_user[:county], election_year_id: session[:election_year]).pluck(:id).last

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
    @survey.data.election_year_id = session[:election_year]
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
    # session[session_model_params].deep_merge!(params[model_singular]) if params[model_singular]
    @current_session = params[model_singular]
    # session[session_model_params] if session[session_model_params]
  end

  def survey_from_record_id
    @survey = GeneralSurvey.new( klass.find(params[:id]) )
  end

  def model_name
    @model_name ||= self.class.to_s.gsub('Controller', '').downcase
  end

  def model_singular
    @model_singular ||= model_name.singularize
  end

  def session_model_params
    @session_model_params ||= "#{model_singular}_params"
  end

  def klass
    @klass ||= model_name.singularize.capitalize.constantize
  end

  def flash_message
    if self.action_name == 'create'
      action_msg = 'Successfully Saved'
    elsif self.action_name == 'update'
      action_msg = 'Successfully Updated'
    end

    if model_singular == 'election_profile'
      msg = "#{action_msg} Election Profile Information for the #{@survey.election.year}"
    else
      msg = "#{action_msg} #{view_context.format_survey_label @survey.category.name} Costs for the #{@survey.election.year}"
    end
  end

  def require_election
    redirect_to home_path unless session[:election_year]
  end

  # def set_session_election_year_profile_index
  #   @election_year_profile = ElectionYearProfile.find(params[:election_year_profile_id])
  #   session[:election_profile_year] = @election_year_profile[:id]
  # end

  # def get_session_election_year_profile
  #   if session[:election_profile_year]
  #     @election_year_profile = ElectionYearProfile.find(session[:election_profile_year])
  #   else
  #     redirect_to election_profile_home_path
  #   end
  # end
end

# class ElectionProfilesController < ApplicationController

# before_action :get_user, :get_model_name
# before_action :get_election_profile_description, :make_chunks,  except: [:destroy]
# before_action :load_product, :set_election_profile, only: [:show, :update, :edit, :destroy]

# before_action :set_session_election_year_profile_index, only: [:index]
# #before_action :set_session_election_year_profile_edit, only: [:edit]
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



#   private

#   def set_session_election_year_profile_index
#      @election_year_profile = ElectionYearProfile.find(params[:election_year_profile_id])
#      session[:election_profile_year] = @election_year_profile[:id]
#     end

#  def get_session_election_year_profile
#      if session[:election_profile_year]
#         @election_year_profile = ElectionYearProfile.find(session[:election_profile_year])
#        else
#         redirect_to election_profile_home_path
#       end
#     end


#     def set_election_profile
#       @election_profile = ElectionProfile.find(params[:id])
#     end

#     def get_model_name
#       @model_name = "election_profiles"
#     end

#   def load_wizard
#     @wizard = ModelWizard.new(@election_profile || ElectionProfile, session, params)
#     if self.action_name.in? %w[new edit]
#       @wizard.start
#     elsif self.action_name.in? %w[create update]
#       @wizard.process
#     end
#   end

#     def load_product
#     @election_profile = ElectionProfile.find(params[:id])
#   end

#    def get_election_profile_description
#     @category_description = ElectionProfileDescription.where(model_name: @model_name)
#     # @category_name = ElectionProfileDescription.where(model_name: @model_name).pluck(:label ).first.titleize
#      @modal_stuff  = ElectionProfile.make_modals(@category_description)
#   end

#   def make_chunks
#     @form_chunks = ElectionProfile.make_chunks(@model_name)
#   end

#     def election_profile_params
#       params.require(:election_profile).permit(
#       :epems,
#      :eppphwscan,
#      :eppphwdre,
#      :eppphwmarkd,
#      :eppphwpollbk,
#      :eppphwoth,
#      :epetallysys,
#      :epppbalpap,
#      :epppbalaccsd,
#      :eprv,
#      :eppploc,
#      :epprecwpp,
#      :epprecvbm,
#      :epbaltype,
#      :epbalpage,
#      :epbalsampvip,
#      :epvipinsrt,
#      :epbalofficl,
#      :epvbmmail,
#      :epvbmmailprm,
#    :epvbmmailmbp,
#    :epvbmmailuo,
#    :epvbmotc,
#    :epvbmret,
#    :epvbmretprm,
#    :epvbmretmbp,
#    :epvbmretuo,
#    :epvbmundel,
#    :epvbmchal,
#    :epvbmprovc,
#    :epvbmprovnc,
#    :eplangnoeng,
#    :epcand,
#    :epcandfsc,
#    :epcandcd,
#     :epcandwi,
#      :epcandwifsc,
#      :epcandwicd,
#      :epmeasr,
#      :epmeasrfsc,
#      :epmeasrcd,
#     :epicrp,
#      :epicrpfed,
#      :epicrpcounty,
#      :epicrpown,
#      :epicrpoth,
#      :eptotindirc,
#      :eptotelectc,
#      :epcostallrg,
#      :epcostallpre,
#      :epcostallopp,
#      :epcostalloth,
#      :eptotbilled,
#      :eptotcounty,
#      :eptotsb90c,
#      :eptotsb90r,
#      :epmandates,
#      :started,
#      :complete,
#          :current_step,
#          :county,
#          :election_year_profile_id,
#       )
#     end

# end
