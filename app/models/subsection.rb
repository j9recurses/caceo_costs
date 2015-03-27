class Subsection < ActiveRecord::Base
  has_and_belongs_to_many :surveys, join_table: "survey_subsections"
  has_and_belongs_to_many :survey_totals, join_table: "survey_totals_subsections", class_name: 'Survey'

  belongs_to :survey_response, inverse_of: :subsections
  # belongs_to :survey_response_totals, inverse_of: :totals_subsections, class_name: 'SurveyResponse'

  has_many :questions, inverse_of: :subsection
  # has_many :questions, inverse_of: :totals_subsection
end