class Subsection < ActiveRecord::Base
  has_and_belongs_to_many :surveys, join_table: "survey_subsections"
  has_and_belongs_to_many :survey_totals, join_table: "survey_totals_subsections", class_name: 'Survey'

  # belongs_to :survey_response, inverse_of: :subsections
  has_many :questions, inverse_of: :subsection

  def values_for(survey_response)
    ResponseValue.where(question_id: self.questions.pluck(:id), survey_response: survey_response )
  end
end