# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#steps:
#1. run migration to create base tables
#2. run script to create model files for year, county, :cost_category,  :cc_year
#3. run intial seeds db script.
#4. create another migration to create all the cost category tables;
#5. make models for each cost catgory
#6. make controllers
#7. then make views

####Access_codes => need to have one of these to signup
AccessCode.delete_all
AccessCode.create(:user_access_code => "GOC$countyuserPiLOt58*", :access_type => "countyuser")
AccessCode.create(:user_access_code => "Q2admin$teStUser58", :access_type => "q2admin")

####County Info####
CaCountyInfo.delete_all
require 'open-uri'
##populate county information
file_url = 'http://api.sba.gov/geodata/county_links_for_state_of/ca.json'
my_doc = Nokogiri::HTML(open( file_url ))
myhash  = JSON.parse(my_doc)

##populate the hash and create a new record
myhash.each do | k|
  name =  k["name"].to_s
  fips = k["fips_county_cd"].to_i
  url = k["url"]
  url = URI.escape url
  CaCountyInfo.create(:name => name, :fips => fips, :url => url)
end


####populate the election years
ElectionYear.delete_all
ElectionYear.create(:year => 2003)
ElectionYear.create(:year => 2004)
ElectionYear.create(:year => 2005)
ElectionYear.create(:year => 2006)
ElectionYear.create(:year => 2007)
ElectionYear.create(:year => 2008)
ElectionYear.create(:year => 2009)
ElectionYear.create(:year => 2010)
ElectionYear.create(:year => 2011)
ElectionYear.create(:year => 2012)

#load up the cost category table
##cost category table....from file
##make a resources dir if it doesn't exist
CategoryDescription.delete_all
costcategoriesfname = Rails.root.join("resources", "cost_categories_list4.csv").to_s
text=File.open(costcategoriesfname).read
text.gsub!(/\r\n?/, "\n")
text.next
text.each_line do |line|
  lstuff = line.split("\t")
  CategoryDescription.create(:field  => lstuff[0] , :cost_type  => lstuff[1], :model_name => lstuff[2].to_s+"s", :name => lstuff[3] , :label => lstuff[7], :description=> lstuff[8])
end


######
##populate categories
Category.delete_all
electionyears = ElectionYear.all
counties = CaCountyInfo.all
electionyears.each do |y|
  counties.each do |c|
      mycstuff = CategoryDescription.uniq.pluck(:cost_type, :model_name, :name)
      mycstuff.each do | lstuff |
         Category.create( :election_year_id =>y[:id], :county => c[:id],  :cost_type  => lstuff[0], :model_name => lstuff[1].to_s, :name => lstuff[2] )
      end
  end
end

##populate a filter table to filter out fields that are perentages or are comments
comments = CategoryDescription.where("label like '%comment%'").pluck(:field)
comments  = comments.to_s
FilterCost.create(:fieldlist => comments, :filtertype => "comment" )
percents  =  CategoryDescription.where("label like '%percent%'").pluck(:field)
percents  = percents.to_s
FilterCost.create(:fieldlist => percents, :filtertype => "percent")
hours =  CategoryDescription.where("label like '%hours worked%'").pluck(:field)
hours = hours.to_s
FilterCost.create(:fieldlist => hours, :filtertype => "hour")


