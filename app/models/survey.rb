class Survey < ActiveRecord::Base
  has_many :survey_responses, inverse_of: :survey, foreign_key: :response_type, primary_key: :response_type
  has_many :questions, inverse_of: :survey
  has_and_belongs_to_many :subsections, join_table: "survey_subsections", class_name: 'Subsection'
  has_and_belongs_to_many :totals_subsections, join_table: "survey_totals_subsections", class_name: 'Subsection'
end