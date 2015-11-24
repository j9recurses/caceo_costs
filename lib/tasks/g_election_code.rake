namespace :caceo do
  desc "generate code from election name"
  task g_election_code: :environment do
    Election.all.each do |e|
      case e.name
      when /(\d+).+General/
        e.code = "#{$1}g"
      when /(\d+).+Special/
        e.code = "#{$1}s"
      when /(\d+).+Primary/
        e.code = "#{$1}p"
      end
      e.save!
    end
  end
end