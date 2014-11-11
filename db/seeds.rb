
##########first###########
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

CaCountyInfo.create(name: "Test County")


####populate the election years
ElectionYear.delete_all
ElectionYear.create(:year => 2003)
ElectionYear.create(:year => 2004)
ElectionYear.create(:year => 2005)
ElectionYear.create(:year => 2006)
ElectionYear.create(:year => 2008)
ElectionYear.create(:year => 2009)
ElectionYear.create(:year => 2010)
ElectionYear.create(:year => 2012)

#load up the cost category table
##cost category table....from file
##make a resources dir if it doesn't exist
CategoryDescription.delete_all
costcategoriesfname = Rails.root.join("resources", "cost_categories_list5.csv").to_s
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

Category.where(:name => 'name').destroy_all
#####Next##########
Category.where(:name => 'name').destroy_all

#categories are in the 5.csv...need to delete them out of 4.
fieldstodelete = ['salbaltotbe','salbaltotbep', 'salbaltothrs','salpptotbe','salpptotbep','salpptothrs','salpwtotbe','salpwtotbep','salpwtothrs','salvbmtotbe','salvbmtotbep','salvbmtothrs','salbctotbe','salbctotbep','salbctothrs','salcanbe','salcanbep','salcantothrs','salmedhrs','saldojobe','saldojobep','saldojohrs','salothbe','salothbep','salothhrs']
fieldstodelete.each do | fd|
  CategoryDescription.where(:field => fd).destroy_all
end

#add the years to the election profile table
ElectionYearProfile.destroy_all
electionprofilelist = [[ '2014 Primary Election' , '06-03-2014', 2014, 'Primary'],['2012 General Election', '11-06-2012', 2012, 'General'],
['2012 Presidential Primary Election', '06-05-2012', 2012 , 'Presidential Primary'],
['2010 General Election' , '11-02-2010', 2010, 'General' ],
['2010 Primary Election',  '06-08-2010', 2010, 'Primary'],
['2009 Special Election', '05-19-2009',  2009, 'Special'],
['2008 General Election' , '11-04-2008', 2008, 'General' ],
['2008 Primary Election', '06-03-2008', 2008, 'Primary'],
['2008 Presidential Primary Election', '02-05-2008', 2008, 'Presidential Primary'],
['2006 General Election', '11-07-2006', 2006, 'General'],
['2006 Primary Election' ,'06-06-2006', 2006, 'Primary'],
['2005 Special Election', '11-08-2005', 2005, 'Special'],
['2004 General Election', '11-02-2004', 2004, 'General'],
['2004 Primary Election', '03-02-2004', 2004, 'Primary'] ]
electionprofilelist.each do | elist|
  ElectionYearProfile.create(:year=> elist[0], :election_dt => elist[1], :year_dt => elist[2], :election_type => elist[3])
end

#load up the information to populate the election_profile_description_table
ElectionProfileDescription.destroy_all
electionprofilesfname = Rails.root.join("resources", "election_profiles_descrip.csv").to_s
text=File.open(electionprofilesfname).read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  lstuff = line.split("\t")
  ElectionProfileDescription.create(:field  => lstuff[0] , :label  => lstuff[1], :model_name => lstuff[2].to_s, :description=> lstuff[3], :fieldtype=> lstuff[4])
end

###then

#update some category description and election profile category typo errors
CategoryDescription.where( 'description LIKE ?', '%Postage to mail UOCAVA sample and official ballots and other UOCAVA mailings%').update_all(description: "Postage to mail UOCAVA sample and official ballots and other UOCAVA mailings, if not free.")
CategoryDescription.where( 'description LIKE ?', '%Which method did you use to arrive at your indirect cost rate – id you construct your own rate?%').update_all(description: "Which method did you use to arrive at your indirect cost rate? Did you construct your own rate?")
CategoryDescription.where( 'description LIKE ?', '%Which method did you use to arrive at your indirect cost rate- id you use the County Audito%').update_all(description: "Which method did you use to arrive at your indirect cost rate? Did you use the County Auditor's rate?")
CategoryDescription.where( 'description LIKE ?', '%Which method did you use to arrive at your indirect cost rate- id you use the Federal Indirect Cost Allocation Plan to arrive at the Indirect Cost rate?%').update_all(description: 'Which method did you use to arrive at your indirect cost rate? Did you use the Federal Indirect Cost Allocation Plan to arrive at the Indirect Cost rate?')
CategoryDescription.where( 'description LIKE ?', '%Which method did you use to arrive at your indirect cost rate-id you use arrive at your rate differently from the methods above?%').update_all(description: "Which method did you use to arrive at your indirect cost rate? Did you use arrive at your rate differently from the methods above?")
CategoryDescription.where( 'description LIKE ?', '%How did you allocate your costs to cities and districts- Did you use the number of registered voters to allocate your costs to cities and districts?%').update_all(description: 'How did you allocate your costs to cities and districts? Did you use the number of registered voters to allocate your costs to cities and districts?')
CategoryDescription.where( 'description LIKE ?', '%How did you allocate your costs to cities and districts- Did you use the number of precincts to allocate your costs to cities and districts?%').update_all(description: 'How did you allocate your costs to cities and districts? Did you use the number of precincts to allocate your costs to cities and districts?')
CategoryDescription.where( 'description LIKE ?', '%How did you allocate your costs to cities and districts- Did you use the number of polling places to allocate your costs to cities and districts?%').update_all(description: 'How did you allocate your costs to cities and districts? Did you use the number of polling places to allocate your costs to cities and districts?')
CategoryDescription.where( 'description LIKE ?', '%How did you allocate your costs to cities and districts- Did you use some other method not mentioned above to allocate your costs to cities and districts?%').update_all(description:'How did you allocate your costs to cities and districts? Did you use some other method not mentioned above to allocate your costs to cities and districts?')
CategoryDescription.where( 'description LIKE ?', '%Were there federal or state mandates that increased costs in this specific election? Add previous mandates that were not implemented until this election. (open ended field for respondents to fill out%').update_all(description: "Were there federal or state mandates that increased costs in this specific election? Add previous mandates that were not implemented until this election.")

#update the names for the election year profiles
ElectionYearProfile.where( year: '2014 Primary Election').update_all(year: '2014 Statewide Direct Primary Election',  edate_full: 'June 3, 2014')
ElectionYearProfile.where( year: '2012 General Election').update_all(year: '2012 Presidential General Election', edate_full: 'November 6, 2012')
ElectionYearProfile.where( year: '2012 Presidential Primary Election').update_all( edate_full: 'June 5, 2012')
ElectionYearProfile.where( year: '2010 General Election').update_all( edate_full: 'November 2, 2010')
ElectionYearProfile.where( year: '2010 Primary Election').update_all(year: '2010 Statewide Direct Primary Election',   edate_full: 'June 8, 2010')
ElectionYearProfile.where( year: '2009 Special Election').update_all(year: '2009 Statewide Special Election',   edate_full: 'May 19, 2009')
ElectionYearProfile.where( year: '2008 General Election').update_all(year: '2008 Presidential General Election', edate_full: 'November 4, 2008')
ElectionYearProfile.where( year: '2008 Primary Election').update_all(year: '2008 Statewide Direct Primary Election',  edate_full: 'June 3, 2008')
ElectionYearProfile.where( year: '2008 Presidential Primary Election').update_all( edate_full: 'February 5, 2008')
ElectionYearProfile.where( year: '2006 General Election').update_all( edate_full: 'November 7, 2006')
ElectionYearProfile.where( year: '2006 Primary Election').update_all(year: '2006 Gubernatorial Primary Election',  edate_full: 'June 6, 2006')
ElectionYearProfile.where( year: '2005 Special Election').update_all( year: '2005 Statewide Special Election',   edate_full: 'November 8, 2005')
ElectionYearProfile.where( year: '2004 General Election').update_all(year: '2004 Presidential General Election', edate_full: 'November 2, 2004')
ElectionYearProfile.where( year: '2004 Primary Election').update_all( year: '2004 Presidential Primary Election', election_type: 'Presidential Primary', edate_full: 'March 2, 2004')
ElectionYearProfile.where( year: '2009 Statewide Special Election').update_all( election_dt: '2009-06-19')

#update the election years
ElectionYear.where(year: '2003').destroy_all
ElectionYear.where( year: '2012').update_all(year: '2012 Presidential General Election', election_dt: '2012-11-06', edate_full: 'November 6, 2012', :year_dt => 2012 )
ElectionYear.where( year: '2010').update_all( year: '2010 General Election',  edate_full: 'November 2, 2010', election_dt: '2010-11-02', :year_dt => 2010 )
ElectionYear.where( year: '2009').update_all( election_dt: '05-19-2009', year: '2009 Statewide Special Election',   edate_full: 'May 19, 2009', election_dt: '2009-05-19', :year_dt => 2009 )
ElectionYear.where( year: '2008').update_all(year: '2008 Presidential General Election', edate_full: 'November 4, 2008', election_dt: '2008-11-04', :year_dt => 2008)
ElectionYear.where( year: '2006').update_all( year: '2006 General Election', edate_full: 'November 7, 2006', election_dt: '2006-11-07', :year_dt => 2006)
ElectionYear.where( year: '2005').update_all( year: '2005 Statewide Special Election',  edate_full: 'November 8, 2005', election_dt: '2005-11-08', :year_dt => 2005)
ElectionYear.where( year: '2004').update_all(year: '2004 Presidential General Election', edate_full: 'November 2, 2004', election_dt: '2004-11-02', :year_dt => 2004)

#create the new elections that dont exist for the election year table
ElectionYear.create(:year => '2014 Statewide Direct Primary Election', :election_type =>  'Primary',  :edate_full =>  'June 3, 2014', :election_dt => '2014-06-03', :year_dt => 2014)
ElectionYear.create( :year => '2012 Presidential Primary Election',  :election_type =>  'Presidential Primary', :edate_full =>  'June 5, 2012', :election_dt => '2012-06-05',  :year_dt => 2012)
ElectionYear.create( :year => '2010 Statewide Direct Primary Election',  :election_type =>  'Primary', :edate_full =>  'June 8, 2010',  :election_dt =>  '2010-06-08',  :year_dt => 2010)
ElectionYear.create(:year =>  '2008 Statewide Direct Primary Election',  :election_type =>  'Primary',  :edate_full=> 'June 3, 2008', :election_dt =>  '2008-06-03',  :year_dt => 2008)
ElectionYear.create(:year => '2008 Presidential Primary Election', :election_type =>  'Presidential Primary',  :edate_full => 'February 5, 2008', :election_dt => '2008-02-05',  :year_dt => 2008)
ElectionYear.create(:year =>  '2006 Gubernatorial Primary Election',  :election_type =>  'Primary',  :edate_full => 'June 6, 2006', :election_dt => '2006-06-06',  :year_dt => 2006)
ElectionYear.create(:year =>  '2004 Presidential Primary Election', election_type: 'Presidential Primary', :edate_full => 'March 2, 2004', :election_dt => '2004-03-02',  :year_dt => 2004)


######
##populate categories
electionyears = ElectionYear.all
counties = CaCountyInfo.all
seen_election_ids =  Category.pluck('election_year_id').uniq
electionyears.each do |y|
  if not( seen_election_ids.include?(y[:id]))
  counties.each do |c|
      mycstuff = CategoryDescription.uniq.pluck(:cost_type, :model_name, :name)
      mycstuff.each do | lstuff |
         Category.create( :election_year_id =>y[:id], :county => c[:id],  :cost_type  => lstuff[0], :model_name => lstuff[1].to_s, :name => lstuff[2] )
      end
    end
  end
end


####################last file #################



#CategoryDescription.where(field: 'ssbalprisb').destroy_all
#CategoryDescription.where(field: 'ssbalpriob').destroy_all

#load up the information to populate the election_profile_description_table
ElectionProfileDescription.destroy_all
electionprofilesfname = Rails.root.join("resources", "election_profiles_descriptions_new.csv").to_s
text=File.open(electionprofilesfname).read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  lstuff = line.split("\t")
  ElectionProfileDescription.create(:field  => lstuff[0] , :label  => lstuff[1], :model_name => lstuff[2].to_s, :description=> lstuff[3], :fieldtype=> lstuff[4])
end

CategoryDescription.destroy_all
categoriesfname = Rails.root.join("resources", "cost_categories_new.csv").to_s
text=File.open(categoriesfname).read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  lstuff = line.split("\t")
  CategoryDescription.create(:field  => lstuff[0] ,  :model_name => lstuff[1].to_s, :cost_type =>  lstuff[2], :name =>  lstuff[3], :label  => lstuff[4], :description=> lstuff[5])
end


#make the category fields for the new cost category
#also need to make a route
electionyears = ElectionYear.all
counties = CaCountyInfo.all
electionyears.each do |y|
  counties.each do |c|
      mycstuff = CategoryDescription.where(name: 'Ballot counting services and supplies ').uniq.pluck(:cost_type, :model_name, :name)
      mycstuff.each do | lstuff |
         Category.create( :election_year_id =>y[:id], :county => c[:id],  :cost_type  => lstuff[0], :model_name => lstuff[1].to_s, :name => lstuff[2] )
      end
  end
end

FilterCost.where(filtertype: "comment").update_all(fieldlist: '["salbalcomment", "salppcomment", "salpwhcomment", "salvbmcomment", "salbccomment", "salcancomment", "salmedcomment", "saldojocomment", "salothcomment", "ssbalcomment", "ssposcomment", "sspwcomment", "ssppcomment", "ssvehcomment", "sscancomment", "ssmedcomment", "ssothcomment", "ssbccomment"]')
