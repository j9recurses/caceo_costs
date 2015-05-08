class SurveyResponse < ActiveRecord::Base
  belongs_to :election, class_name: "ElectionYear"
  belongs_to :response, polymorphic: true, autosave: true, validate: true, dependent: :destroy
  belongs_to :survey, inverse_of: :survey_responses, foreign_key: :response_type
  belongs_to :county, inverse_of: :survey_responses
  has_many :questions, foreign_key: 'survey_id', primary_key: 'response_type'
  has_many :subsections, through: :survey
  has_many :totals_subsections, through: :survey, class_name: 'Subsection'
  has_many :values, inverse_of: :survey_response, class_name: 'ResponseValue', dependent: :destroy

  validates :county, presence: true
  validates :election, presence: true
  validates :response, presence: true

  after_save :sync_values
  after_touch :sync_values

  def set_null_fields_to_na
    questions.where(na_able: true).select(:field, :na_field).each do |r|
      if response[r.field] == nil
        response[r.na_field] = true
      end
    end
  end

  def respond(question, value)
    response.send(question.field + '=', value)
  end

private
  def sync_values
    ResponseValue.sync_survey_response self
  end
end
