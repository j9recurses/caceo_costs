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



