namespace :caceo do

  desc "update 'what's this?' on single language ballots"
  task single_language: :environment do
    rel = CategoryDescription.where('description like "%English%"')
    languages = ["English", "Chinese", "Korean", "Spanish", "Vietnamese", "Japanese", "Tagalog", "Khmer", "Hindi", "Thai", "Other languages"]

    rel.each do |r|
      lang = languages.detect { |l| r.label.match(l) }

      r.description = r.description.gsub("English", lang)
      r.save!
    end
  end
end