class AccessCode < ActiveRecord::Base
  belongs_to :county, inverse_of: :access_code, class_name: "CaCountyInfo", foreign_key: "county_id"
end
