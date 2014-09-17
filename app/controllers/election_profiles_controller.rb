class ElectionProfilesController < ApplicationController
before_action :authenticate_user
before_action :get_user, :get_model_name
before_action :set_session_election_year_profile_new, only: [:new]
before_action :set_session_election_year_profile_edit, only: [:edit]
before_action :get_session_election_year_profile, only: [:create, :update, :show]
before_action :get_election_profile_description, :make_chunks,  except: [:destroy]
before_action :load_product, :set_election_profile, only: [:show, :update, :edit, :destroy]
before_action :load_wizard, only: [:new, :edit, :create, :update]

def index
  @election_profile_stuff = ElectionProfile.where(county: @user[:county], election_year_profile_id: params[:election_year_profile_id]).pluck(:id)
  if @election_profile_stuff.size == 0
     redirect_to new_election_profile_path(params[:election_year_profile_id])
  else
    redirect_to election_profile_path(@election_profile_stuff)
  end
end

 def show
    @election_profile = ElectionProfile.find(params[:id])
  end

  def new
     @election_profile = @wizard.object
  end

  def edit
  end

  def create
    @election_profile = @wizard.object
    if @wizard.save
        ElectionProfile.category_status(@election_profile[:id], @election_profile)
        redirect_to @election_profile, notice: "The  Election Profile Information for the " + @election_year_profile[:year] + " That You Entered Was Successfully Updated"
      else
        render :new
       end
    end

  def update
     if @wizard.save
      ElectionProfile.category_status( @election_profile[:id], @election_profile)
      redirect_to @election_profile, notice: "The  Election Profile Information for the "  + @election_year_profile[:year] + "That You Entered Was Successfully Updated"
    else
      render action: 'edit'
    end
  end

    def destroy
    @election_profile.destroy
    redirect_to election_profiles_path(:election_year_profile_id => @election_profile[:election_year_profile_id]  )
  end



  private

  def set_session_election_year_profile_new
     @election_year_profile = ElectionYearProfile.find(params[:format])
     session[:election_profile_year] = @election_year_profile[:id]
    end

 def get_session_election_year_profile
     if session[:election_profile_year]
        @election_year_profile = ElectionYearProfile.find(session[:election_profile_year])
       else
        redirect_to election_profile_home_path
      end
    end

  def set_session_election_year_profile_edit
     @election_profile = ElectionProfile.find(params[:id])
     @election_year_profile = ElectionYearProfile.find(@election_profile[:election_year_profile_id])
     session[:election_profile_year] = @election_year_profile[:id]
    end


    def set_election_profile
      @election_profile = ElectionProfile.find(params[:id])
    end

    def get_model_name
      @model_name = "election_profiles"
    end

  def load_wizard
    @wizard = ModelWizard.new(@election_profile || ElectionProfile, session, params)
    if self.action_name.in? %w[new edit]
      @wizard.start
    elsif self.action_name.in? %w[create update]
      @wizard.process
    end
  end

    def load_product
    @election_profile = ElectionProfile.find(params[:id])
  end

   def get_election_profile_description
    @category_description = ElectionProfileDescription.where(model_name: @model_name)
    # @category_name = ElectionProfileDescription.where(model_name: @model_name).pluck(:label ).first.titleize
     @modal_stuff  = ElectionProfile.make_modals(@category_description)
  end

  def make_chunks
    @form_chunks = ElectionProfile.make_chunks(@model_name)
  end

    def election_profile_params
      params.require(:election_profile).permit(
      :epems,
     :eppphwscan,
     :eppphwdre,
     :eppphwmarkd,
     :eppphwpollbk,
     :eppphwoth,
     :epetallysys,
     :epppbalpap,
     :epppbalaccsd,
     :eprv,
     :eppploc,
     :epprecwpp,
     :epprecvbm,
     :epbaltype,
     :epbalpage,
     :epbalsampvip,
     :epvipinsrt,
     :epbalofficl,
     :epvbmmail,
     :epvbmmailprm,
   :epvbmmailmbp,
   :epvbmmailuo,
   :epvbmotc,
   :epvbmret,
   :epvbmretprm,
   :epvbmretmbp,
   :epvbmretuo,
   :epvbmundel,
   :epvbmchal,
   :epvbmprovc,
   :epvbmprovnc,
   :eplangnoeng,
   :epcand,
   :epcandfsc,
   :epcandcd,
    :epcandwi,
     :epcandwifsc,
     :epcandwicd,
     :epmeasr,
     :epmeasrfsc,
     :epmeasrcd,
    :epicrp,
     :epicrpfed,
     :epicrpcounty,
     :epicrpown,
     :epicrpoth,
     :eptotindirc,
     :eptotelectc,
     :epcostallrg,
     :epcostallpre,
     :epcostallopp,
     :epcostalloth,
     :eptotbilled,
     :eptotcounty,
     :eptotsb90c,
     :eptotsb90r,
     :epmandates,
     :started,
     :complete,
         :current_step,
         :county,
         :election_year_profile_id,
      )
    end

end
