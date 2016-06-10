namespace :caceo do
  desc "add 2016p surveys"
  task add_2016p: :environment do
    Election.create!(
      name: '2016 Presidential Primary Election',
      code: '2016p',
      election_dt: Date.new(2016, 6, 7)
    )
  end
end