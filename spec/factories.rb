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

  factory :election do
    sequence(:id)   { |n| n }
    sequence(:name) { |n| "#{(2000 + n).to_s} General Election" }
    # initialize_with { Election.find_or_initialize_by(name: name, id: id) }
  end

  factory :county do
    sequence(:id)   { |n| n }
    sequence(:name) { |n| "Test#{n} County" }
    initialize_with { County.find_or_initialize_by(id: id, name: name) }
  end

  factory :tech_software, class: TechVotingSoftware do
    county
    factory :tech_software_response do
      purchase_price_software 999
      labor_costs 1
    end
  end

  factory :tech_machine, class: TechVotingMachine do
    county
  end

  factory :sr, class: SurveyResponse do
    county
    election

    factory(:survey_response_ss){ association :response, factory: :ss_response }
    factory :survey_response_sal do
      association :response, factory: :sal_response
    end

    factory :survey_response_ep, aliases: [:sr_ep] do
      association :response, factory: :ep_response
    end


    factory :survey_response_ss_with_values do
      association :response, factory: :ss_response_with_values
      after(:create) { |sr| ResponseValue.sync_survey_response sr }
    end
    factory :survey_response_sal_with_values, aliases: [:survey_response] do
      association :response, factory: :sal_response_with_values
      after(:create) { |sr| ResponseValue.sync_survey_response sr }
    end
    factory :survey_response_ep_with_values, aliases: [:sr_ep_vals] do
      association :response, factory: :ep_response_with_values
      after(:create) { |sr| ResponseValue.sync_survey_response sr }
    end
  end

  factory :ss_response, class: Ssveh do
    factory :ss_response_with_values do
      ssvehfuel 135
      ssvehrent 20
      ssvehcount 165
    end
  end

  factory :sal_response, class: Salbal do
    factory :sal_response_with_values do
      salbaldesign 135
      salbaltrans 20
      salbalorder 165
    end
  end

  factory :ep_response, class: ElectionProfile do
    factory :ep_response_with_values do
      epppbalpapar true
      eprv 20
      epbalpage 'elections have profiles'
    end
  end
end