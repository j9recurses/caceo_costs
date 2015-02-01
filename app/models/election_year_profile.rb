class ElectionYearProfile < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true
  has_many :election_profiles, inverse_of: :election_year_profile

  default_scope { order(election_dt: :desc) }
  scope :county_profile, ->(county_id) { includes(:election_profiles).where('election_profiles.county_id = ? OR election_profiles.id IS NULL', county_id).references(:election_profiles) }

  def county_profile( id )
    election_profiles.where( county_id: id ).last
  end
  # scope :county_profiles, ->(county_id) { joins("LEFT OUTER JOIN election_profiles ON election_profiles.county_id = ? AND election_profiles.election_year_profile_id = election_year_profile.id", county_id.to_s) }
end
