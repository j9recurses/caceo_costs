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




