FactoryGirl.define do
  factory :user do
    username 'zbo'
    email 'example@website.com'
    county 59
  end

  factory :observer, class: User do
    username 'zbo'
    email 'example@website.com'
    county 59
    observer_role
  end

  factory :observer_role, class: Role do
    name 'observer'
  end
end