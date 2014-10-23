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
