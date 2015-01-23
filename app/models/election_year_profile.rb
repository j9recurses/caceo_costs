class ElectionYearProfile < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true
  has_many :election_profiles, inverse_of: :election_year_profile

  default_scope { order(election_dt: :desc) }
  scope :county_profile, ->(county_id) { includes(:election_profiles).where('election_profiles.county_id = ? OR election_profiles.id IS NULL', county_id).references(:election_profiles) }

  def county_profile( id )
    election_profiles.where( county_id: id ).last
  end
  # scope :county_profiles, ->(county_id) { joins("LEFT OUTER JOIN election_profiles ON election_profiles.county_id = ? AND election_profiles.election_year_profile_id = election_year_profile.id", county_id.to_s) }

  # def self.get_all_years(user)
  #   years = ElectionYearProfile.all.order('election_dt DESC').pluck(:year_dt).uniq
  #   myyears = Array.new()
  #   years.each do |y|
  #      election_yr_overview = Hash.new()
  #       election_yr_overview[:year_dt] = y.to_s
  #       year_elections_ids =  ElectionYearProfile.where(year_dt: y).pluck(:id)
  #      election_profile_started_yr = ElectionProfile.where( county_id: user[:county_id], started: 1, election_year_profile_id: year_elections_ids)
  #      election_profile_complete_yr = ElectionProfile.where( county_id: user[:county_id], complete: 1,  election_year_profile_id: year_elections_ids)
  #     if election_profile_started_yr.size > 0
  #       election_yr_overview[:started] ="<span style=\"color:blue\"> &#10004</span>"
  #     else
  #       election_yr_overview[:started] ="<span style=\"color:red\">&#x2717</span>"
  #     end
  #    if election_profile_complete_yr.size > 0
  #       election_yr_overview[:done] = "<span style=\"color:blue\"> &#10004</span>"
  #     else
  #       election_yr_overview[:done] =  "<span style=\"color:red\">&#x2717</span>"
  #     end
  #    year_elections =  ElectionYearProfile.where(year_dt: y)
  #      all_years_electionz = Array.new
  #   year_elections.each do |ye|
  #     single = Array.new()
  #     single << ye[:id]
  #     single <<  ye[:year]
  #     election_profile_started= ElectionProfile.where( county_id: user[:county_id], started: 1, election_year_profile_id: ye[:id])
  #     election_profile_complete= ElectionProfile.where( county_id: user[:county_id], complete: 1, election_year_profile_id: ye[:id])
  #     if election_profile_started.size > 0
  #       single<< "<span style=\"color:blue\"> &#10004</span>"
  #     else
  #       single<<"<span style=\"color:red\">&#x2717</span>"
  #     end
  #    if election_profile_complete.size > 0
  #        single<<"<span style=\"color:blue\"> &#10004</span>"
  #     else
  #        single<<   "<span style=\"color:red\">&#x2717</span>"
  #     end
  #      all_years_electionz << single
  #   end
  #   election_yr_overview[:all_years_electionz] = all_years_electionz
  #   myyears  << election_yr_overview
  # end
  #   return myyears
  # end
end
