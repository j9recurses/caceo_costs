class SurveyResponse < ActiveRecord::Base
  belongs_to :election, class_name: "ElectionYear"
  belongs_to :response, polymorphic: true
  belongs_to :survey, inverse_of: :survey_responses, primary_key: :response_type, foreign_key: :response_type
  belongs_to :county, inverse_of: :survey_responses
  has_many :questions, through: :survey
  has_many :subsections, through: :survey
  has_many :totals_subsections, through: :survey, class_name: 'Subsection'

  validates :county, presence: true

  def set_null_fields_to_na
    questions.where(na_able: true).select(:field, :na_field).each do |r|
      if response[r.field] == nil
        response[r.na_field] = true
      end
    end
  end
end
