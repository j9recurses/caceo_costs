class Subsection < ActiveRecord::Base
  has_and_belongs_to_many :surveys, join_table: "survey_subsections"
  has_many :questions, inverse_of: :subsection
end