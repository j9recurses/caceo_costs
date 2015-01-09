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
end