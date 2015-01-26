require 'csv'

def to_bool(str)
  return true if str == true || str =~ (/^(true|t|yes|y|1)$/i)
  return false if str == false || str.blank? || str =~ (/^(false|f|no|n|0)$/i)
  raise ArgumentError.new("invalid value for Boolean: \"#{str}\"")
end

namespace :caceo do
  desc 'create initial faqs'
  task faqs: :environment do
    Faq.create(question: "My county does not break down salaries by task. Should we estimate them for this project?", answer: "We ask that counties do not estimate costs for this survey. Please enter costs only for the questions that apply to your county. For all other questions, please check the \"N/A\" box and use the comment box to explain further about your cost-keeping.")
    Faq.create(question: "What is the timeline for working on the survey?", answer: "Please complete one election of the survey but the end of January 16, 2015. Please complete all elections in the survey by March 20, 2016.")
  end

  namespace :setup do
    # desc 'run all setup tasks'
    # task :all => [:]

    desc "update categories from csv"
    task categories: :environment do
      doc = CSV.read(Rails.root.join('categories_nov11.csv'))
      columns = doc.shift

      doc.each do |row|
        c = Category.where( model_name: row[3], county: row[7], election_year_id: row[8] )
          .update_all( started: to_bool( row[4] ), complete: to_bool( row[5] ), model_total: row[6].to_i )
      end
    end


    desc "update 'what's this?' on single language ballots"
    task language: :environment do
      rel = CategoryDescription.where('description like "%English%"')
      languages = ["English", "Chinese", "Korean", "Spanish", "Vietnamese", "Japanese", "Tagalog", "Khmer", "Hindi", "Thai", "Other languages"]

      rel.each do |r|
        lang = languages.detect { |l| r.label.match(l) }

        r.description = r.description.gsub("English", lang)
        r.save!
      end
    end

    desc "generate access codes for counties"
    task county_access: :environment do
      CaCountyInfo.all.each do |county|
        AccessCode.create(county: county, 
          user_access_code: SecureRandom.urlsafe_base64(8), 
          access_type: 'county_user')
      end
    end
  end
end