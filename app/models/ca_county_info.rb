class CaCountyInfo < ActiveRecord::Base
  has_one :access_code, inverse_of: :county, foreign_key: "county_id"
  has_many :users, inverse_of: :county, foreign_key: 'county_id'
  has_many :survey_responses, inverse_of: :county, foreign_key: 'county_id'
  has_many :responses, through: :survey_responses, as: :county, foreign_key: 'county_id'
end
