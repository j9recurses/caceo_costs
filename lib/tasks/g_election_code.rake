namespace :caceo do
  desc "generate code from election name (year)"
  task g_election_code: :environment do
    ElectionYear.all.each do |e|
      case e.year
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