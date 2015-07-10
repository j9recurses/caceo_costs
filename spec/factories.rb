load './app/models/response_value.rb'

FactoryGirl.define do
  factory :user do
    username 'zblotnik'
    email 'example@website.com'
    county
    password 'secret'
    password_confirmation 'secret'
  end

  factory :observer, class: User do
    username 'zbo'
    email 'example@website.com'
    county
    observer_role
  end

  factory :observer_role, class: Role do
    name 'observer'
  end

  factory :announcement do
    message 'new news!'
  end

  factory :election, class:ElectionYear, aliases: [:election_year] do
    id 2020
    year 'General Election 2020'
    initialize_with { ElectionYear.find_or_initialize_by(year: year, id: id) }
  end

  factory :county do
    id 59
    name 'Test County'
    initialize_with { County.find_or_initialize_by(id: id, name: name) }
  end

  factory :sr, class: SurveyResponse do
    county
    election
    factory :survey_response_ss  do association :response, factory: :ss_response  end
    factory :survey_response_sal do association :response, factory: :sal_response end
    factory :survey_response_ep  do association :response, factory: :ep_response  end
    factory :survey_response_ss_with_values do
      association :response, factory: :ss_response_with_values end
    factory :survey_response_sal_with_values, aliases: [:survey_response] do
      association :response, factory: :sal_response_with_values end
    factory :survey_response_ep_with_values do
      association :response, factory: :ep_response_with_values end
  end

  factory :ss_response, class: Ssveh do
    county_id 59
    election_year_id 2020

    factory :ss_response_with_values do
      ssvehfuel 135
      ssvehrent 20
      ssvehcount 165
    end
  end

  factory :sal_response, class: Salbal do
    county_id 59
    election_year_id 2020
    factory :sal_response_with_values do
      salbaldesign 135
      salbaltrans 20
      salbalorder 165
    end
  end

  factory :ep_response, class: ElectionProfile do
    county_id 59
    election_year_id 2020
    factory :ep_response_with_values do
      epppbalpapar true
      eprv 20
      epbalpage 'elections have profiles'
    end
  end
end