class SurveyResponse < ActiveRecord::Base
  belongs_to :election, class_name: "ElectionYear"
  belongs_to :response, polymorphic: true
  belongs_to :survey, inverse_of: :survey_responses
  belongs_to :county, inverse_of: :survey_responses, class_name: "CaCountyInfo", foreign_key: "county_id"
end
