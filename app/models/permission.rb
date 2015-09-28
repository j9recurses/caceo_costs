class Permission
  def initialize(user)
    @user = user
    allow :users, [:new, :create, :security_question, :securityquestion, :securityquestion_submit]
    allow :users, [:login, :login_attempt, :forgot_password, :reset_password, :update_password, :updatepassword_submit]
    allow :password_resets, [:new, :create, :edit, :update]
    allow :messages, [:new, :create]
    if user
      allow :users, [:profile, :logout]
      allow :elections, :index
      allow :surveys, :index
      allow :announcements, :index
      allow :faqs, :index
      if user.observer?
        allow :users, :update
        allow :election_profiles, [:index, :show]
        allow :election_technologies, :index
        allow_observe :tech_voting_machines
        allow_observe :tech_voting_softwares
        allow_observe :survey_responses
      else
        allow :election_technologies, :index
        allow_respond :tech_voting_machines
        allow_respond :tech_voting_softwares
        allow_respond :survey_responses
      end

      if user.admin?
        allow [:survey_responses, :response_values, :questions, :counties], [:index]
        allow :activities, [:index, :summary, :earlier]
        allow :reports, [:progress, :responses]
        # allow :data, [:index]
        allow :announcements, [:new, :create, :destroy]
        allow :faqs, [:new, :create, :edit, :update, :destroy]
      end
    end
  end

  def allow_respond(resource)
    allow resource, [:index, :new]
    allow resource, [:create] do |session|
      @user.county.id == session[:county_id].to_i
    end
    # only tech surveys have a delete action
    allow resource, [:show, :edit, :update, :destroy, :delete] do |resource|
      @user.county.id == resource.county_id
    end
  end

  def allow_observe(resource)
    allow resource, [:index]
    allow resource, [:show] do |r|
      @user.county.id == r.county_id
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