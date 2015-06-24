load './app/models/response_value.rb'

FactoryGirl.define do
  factory :user do
    username 'zblotnik'
    email 'example@website.com'
    county_id 59
    password 'secret'
    password_confirmation 'secret'
  end

  factory :observer, class: User do
    username 'zbo'
    email 'example@website.com'
    county_id 59
    observer_role
  end

  factory :observer_role, class: Role do
    name 'observer'
  end

  factory :announcement do
    message 'new news!'
  end

  factory :survey_response do
    county_id 59
    election_id 19
    response
  end

  factory :survey_response_with_values, class: SurveyResponse do
    county_id 59
    election_id 19
    association :response, factory: :response_with_values
    # after(:create) do |sr|
    #   ResponseValue.sync_survey_response sr
    # end   
  end

  factory :response, class: Ssveh do
    county_id 59
    election_year_id 19
    factory :response_with_values do
      ssvehfuel 135
      ssvehrent 20
      ssvehcount 165
    end
  end
end