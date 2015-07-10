class SurveyResponse < ActiveRecord::Base
  belongs_to :election, class_name: "ElectionYear", foreign_key: 'election_id'
  belongs_to :response, polymorphic: true, autosave: true, dependent: :destroy
  belongs_to :survey, inverse_of: :survey_responses, foreign_key: :response_type
  belongs_to :county, inverse_of: :survey_responses
  has_many :questions, foreign_key: 'survey_id', primary_key: 'response_type'
  # has_many :subsections, through: :survey
  has_many :totals_subsections, through: :survey, class_name: 'Subsection'
  has_many :values, inverse_of: :survey_response, class_name: 'ResponseValue'

  validates_associated :response
  validates :county, presence: true
  validates :election, presence: true
  validates :response, presence: true

  def set_null_fields_to_na
    questions.where(na_able: true).select(:field, :na_field).each do |r|
      if response[r.field] == nil
        response[r.na_field] = true
      end
    end
  end

  def respond(question, value = nil, na:false)
    case question
    when Question
      response.send(question.field + '=', value)
    when String
      response.send(question + '=', value)
    end

    if na
      response.send(question.na_field+'=', true)
    end
  end

  def self.value_ids
    joins(:values)
    .pluck('response_values.id')
  end

  def self.total
    ResponseValue.where(id: value_ids).total
  end

  def total
    ResponseValue.where(id: value_ids).total
  end

  def percent_answered
    values.percent_answered
  end

  def self.percent_answered
    ResponseValue.where(id: value_ids).percent_answered
  end

  def values_in_subsection(subsection)
    q_ids = Question.where(subsection: subsection, survey_id: response_type).pluck(:id)
    values.where(question: q_ids)
  end

  # def survey_names
  #   @survey_names ||= Survey.pluck(:id).map(&:underscore)
  # end

  # ONLY used in forms because Reform does not have good support
  # for polymorphic associations.
  # def method_missing(m, *args, &block)
  #   if m.to_s.match(/(.+)=/) && survey_names.include?($1)
  #     send(:response=, *args)
  #   elsif survey_names.include?(m.to_s)
  #     send(:response)
  #   else
  #     super
  #   end
  # end

  # def respond_to_missing?(m, include_private = false)
  #   m = m.match(/(.+)=/)[1]
  #   survey_names.include?(m) || super
  # end
private
  def sync_values
    ResponseValue.sync_survey_response self
  end
end
