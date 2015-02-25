require 'csv'

namespace :caceo do
  desc 'update Question description text from csv'
  task update_descriptions: :environment do
    altered = []
    CSV.foreach( Rails.root.join('resources/direct_cost_categories-dec8_changes_3.csv'), col_sep: "\t" ) do |row|
      unless row[6].blank?
        altered.push( {model_name: row[1], field: row[0], updated_description: row[6]} )
      end
    end

    altered.each do |hash|
      record = Question.find_by(model_name: hash[:model_name], field: hash[:field])
      record.update_attribute(:description, hash[:updated_description])
    end
  end
end