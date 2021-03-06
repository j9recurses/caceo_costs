CaceoCosts::Application.routes.draw do

  root :to => "users#login"
  get "signup", :to => "users#new" , as: "signup"
  get "login" , :to => "users#login", as: "login"
  get "logout", :to => "users#logout",  as: "logout"
  get  "forgot_password" => "users#forgot_password" ,  as: "forgot_password"
  post "reset_password" => "users#reset_password", as: "reset_password"
  post "login_attempt", :to => "users#login_attempt"
  resources :users
  resources :user_steps
  resources :users do
    get :profile, :on => :member, as: "profile"
     get :securityquestion, :on => :member
     post :securityquestion_submit, :on => :member
     get :update_password, :on => :member
     post :updatepassword_submit , :on => :member
  end

  get "home", :to => "election_years#home", as: "home"
  get "home/:id", :to => "election_years#view_year",  as: "show_election_year"
  resources :election_years do
        resources :categories
    end
  resources :salbals
  resources :salpps
  resources :salpws
  resources :salvbms
  resources :salbcs
  resources :salcans
  resources :salmeds
  resources :saldojos
  resources :saloths
  resources :ssbals
  resources :postages
  resources :sspws
  resources :sspps
  resources :ssvehs
  resources :sscans
  resources :ssmeds
 resources :ssoths

resources :messages, only: [:new, :create]

end
