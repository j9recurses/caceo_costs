CaceoCosts::Application.routes.draw do

  get 'reports/progress',   to: 'reports#progress',  as: 'progress_report'
  get 'reports/responses',  to: 'reports#responses', as: 'responses_report'
  resources :elections do
    resources :surveys
  end  

  resources :survey_responses

  # json
  resources :workshops,       only: [:index]
  resources :questions,       only: [:index]
  resources :response_values, only: [:index]
  resources :counties,        only: [:index]
  resources :surveys,         only: [:index]

  resources :data, only: [:index]
  resources :progress, only: [:index, :show]

  resources :faqs
  resources :announcements
  resources :password_resets
  resources :election_technologies

  get 'activities', to: 'activities#index'
  get 'activities/summary', to: 'activities#summary', as: 'activity_summary'
  get 'activities/earlier', to: 'activities#earlier', as: 'activity_earlier'


  resources :tech_voting_machines do
    get "delete"
  end

  resources :tech_voting_softwares do
    get "delete"
  end

  root :to => "users#login"
  get "signup", to: "users#new" ,    as: "signup"
  get "login" , to: "users#login",   as: "login"
  get "logout", to: "users#logout",  as: "logout"
  get  "forgot_password" => "users#forgot_password",   as: "forgot_password"
  post "reset_password"  => "users#reset_password",    as: "reset_password"
  post "login_attempt", to: "users#login_attempt"
  resources :users
  resources :user_steps
  resources :users do
    get   :profile,           :on => :member, as: "profile"
    get   :securityquestion,  :on => :member
    post  :securityquestion_submit, :on => :member
    get   :update_password,         :on => :member
    post  :updatepassword_submit ,  :on => :member
  end
resources :messages, only: [:new, :create]

end
