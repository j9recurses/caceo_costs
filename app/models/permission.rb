class Permission
  SURVEY_NAMES = %i(postages salbals salbcs salcans saldojos salmeds saloths salpps salpws salvbms ssbals ssbcs sscans ssmeds ssoths sspps sspws ssvehs)

  def initialize(user)
    @user = user
    allow :users, [:new, :create, :security_question, :securityquestion, :securityquestion_submit]
    allow :users, [:login, :login_attempt, :forgot_password, :reset_password, :update_password, :updatepassword_submit]
    allow :password_resets, [:new, :create, :edit, :update]
    allow :messages, [:new, :create]
    if user
      allow :users, [:profile, :logout]
      allow :election_years, :home
      allow :elections, :index
      allow :surveys, :index
      allow :categories, :index
      allow :election_year_profiles, :election_profile_home
      allow :announcements, :index
      allow :faqs, :index
      if user.observer?
        allow :users, :update
        allow :election_profiles, [:index, :show]
        allow :election_technologies, :index
        allow :tech_voting_machines, [:index, :show]
        allow :tech_voting_softwares, [:index, :show]
        SURVEY_NAMES.each do |name|
          allow_observe_survey(name)
        end
      else
        allow :election_profiles, [:index, :new, :create, :show, :edit, :update, :destroy]
        allow :election_technologies, :index
        allow :tech_voting_machines, [:index, :new, :create, :show, :edit, :update, :destroy, :delete]
        allow :tech_voting_softwares, [:index, :new, :create, :show, :edit, :update, :destroy, :delete]
        SURVEY_NAMES.each do |name|
          allow_survey(name)
        end
        allow_survey(:survey_responses)
      end

      if user.admin?
        allow :activities, [:index, :show]
        allow :announcements, [:new, :create, :destroy]
        allow :faqs, [:new, :create, :edit, :update, :destroy]
      end
    end
  end

  def allow_survey(survey_name)
    allow survey_name, [:index, :new]
    allow survey_name, [:create] do |session|
      @user.county.id == session[:county_id].to_i
    end
    allow survey_name, [:show, :edit, :update, :destroy] do |survey|
      @user.county.id == survey.county_id
    end
  end

  def allow_observe_survey(survey_name)
    allow survey_name, [:index]
    allow survey_name, [:show] do |survey|
      @user.county.id == survey.county_id
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
  
  def allow_all
    @allow_all = true
  end
  
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

end