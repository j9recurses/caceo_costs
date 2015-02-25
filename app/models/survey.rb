class Survey < ActiveRecord::Base
  has_many :survey_responses, inverse_of: :survey
  has_many :questions, inverse_of: :survey
  has_and_belongs_to_many :subsections, join_table: "survey_subsections"
end