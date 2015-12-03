namespace :caceo do
  desc "give 'super' user super_user privileges"
  task super_user: :environment do
    Role.create!(name: 'super_user')
    super_user = User.find_by(username: 'super')
    super_user.roles << Role.find_by(name: 'super_user')
    super_user.save!
  end
end