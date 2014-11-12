require 'csv'

namespace :caceo do
  desc "update categories from csv"
  task categories: :environment do
    doc = CSV.read(Rails.root.join('categories_nov11.csv'))
    columns = doc.shift

    doc.each do |row|
      c = Category.where( model_name: row[3], county: row[7], election_year_id: row[8] )
        .update_all( started: to_bool( row[4] ), complete: to_bool( row[5] ), model_total: row[6].to_i )
    end
  end

  def to_bool(str)
    return true if str == true || str =~ (/^(true|t|yes|y|1)$/i)
    return false if str == false || str.blank? || str =~ (/^(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{str}\"")
  end
end