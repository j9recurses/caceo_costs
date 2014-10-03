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
ElectionYear.where( year: '2012').update_all(year: '2012 Presidential General Election', election_dt: '2012-11-06', edate_full: 'November 6, 2012')
ElectionYear.where( year: '2010').update_all( year: '2010 General Election',  edate_full: 'November 2, 2010', election_dt: '2010-11-02')
ElectionYear.where( year: '2009').update_all( election_dt: '05-19-2009', year: '2009 Statewide Special Election',   edate_full: 'May 19, 2009', election_dt: '2009-05-19')
ElectionYear.where( year: '2008').update_all(year: '2008 Presidential General Election', edate_full: 'November 4, 2008', election_dt: '2008-11-04')
ElectionYear.where( year: '2006').update_all( year: '2006 General Election', edate_full: 'November 7, 2006', election_dt: '2006-11-07')
ElectionYear.where( year: '2005').update_all( year: '2005 Statewide Special Election',  edate_full: 'November 8, 2005', election_dt: '2005-11-08')
ElectionYear.where( year: '2004').update_all(year: '2004 Presidential General Election', edate_full: 'November 2, 2004', election_dt: '2004-11-02')

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

