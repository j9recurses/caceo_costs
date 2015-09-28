class SurveyResponse < ActiveRecord::Base
  belongs_to :election
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
  
  SALARY_TOTALS_SUBSECTIONS = {
    policy: ['Salaries - Tasks', 'Benefits - in Percent', 'Hours Worked'],
    inverse: ['Salaries - Types of Staff and Pay', 'Benefits - in Percent', 'Hours Worked']
  }

  def values_in_subsection(subsection)
    q_ids = Question.where(subsection: subsection, survey_id: response_type).pluck(:id)
    values.where(question: q_ids)
  end

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
    when Symbol
      response.send(question.to_s + '=', value)
    end

    if na
      response.send(question.na_field+'=', true)
    end
  end

  ###########################Percent Complete

  def percent_answered
    values.percent_answered
  end
  alias_method :percent_complete, :percent_answered

  # Delegate to all response_values of SRs in the self relation,
  # return average completeness of entire relation
  def self.percent_answered
    ResponseValue.where(id: value_ids).percent_answered
  end

  # Completeness relative to all possible questions in all elections, counties
  # optionally narrowed down
  def self.overall_completeness(elections: nil, surveys: nil, counties: nil)
    survey_multiplier = if surveys
      Question.where(survey_id: Array(surveys)).count
    else
      Question.count
    end

    county_multiplier   = counties  ? Array(counties).size  : 58
    election_multiplier = elections ? Array(elections).size : Election.count

    grand_total = (survey_multiplier * county_multiplier * election_multiplier).to_f
    completed = ResponseValue.where(id: value_ids).answered.to_f
    ratio = (completed / grand_total).round(2)
    ratio = ratio.nan? ? 0 : ratio
    (ratio * 100).to_i
  end

  def self.query_completeness(query)
    rel = self.where(query)
    rel.overall_completeness(
      counties:   query[:county],
      elections:  query[:election],
      surveys:  query[:survey]
    )
  end

  class << self
    alias_method :percent_complete, :percent_answered
    alias_method :relation_completeness, :percent_answered
  end

  ###########################Totaling

  def self.value_ids
    joins(:values)
    .pluck('response_values.id')
  end

  # Duplication of class and instance to work on relations and instances
  # Strategy passed all the way to ::total_excluded_subsection_ids
  def self.total(strategy=:policy)
    case strategy
    when :policy, :inverse
      total_relation(strategy).total
    # when :raw
    #   value_ids
    else
      raise 'Invalid argument'
    end
  end

  def total(strategy=:policy)
    ids = case strategy
    when :policy, :inverse
      total_relation(strategy).total
    # when :raw
    #   value_ids
    else
      raise 'Invalid argument'
    end
  end

  def self.total_relation(strategy=:policy)
    if pluck(:id).blank?
       ResponseValue.none
    else
      ResponseValue.joins(<<-SQL)
        INNER JOIN (
          SELECT id AS sr_id
          FROM survey_responses
          WHERE survey_responses.id IN( #{ pluck(:id).inject {|memo, obj| memo.to_s + ', ' + obj.to_s} } )
        ) AS sr
        ON sr.sr_id = response_values.survey_response_id
        AND NOT( response_values.question_id IN(
          #{ SurveyResponse.total_excluded_question_ids_string(strategy) }
        ))
      SQL
    end
  end

  def total_relation(strategy=:policy)
    ResponseValue.where(
      survey_response_id: self.id
    ).where.not( response_values: {question_id: 
      SurveyResponse.total_excluded_question_ids_array(strategy)} 
    )
  end

  # total policy
  def self.total_excluded_question_ids_array(strategy=:policy)
    Question.where(<<-SQL
      field = 'ssbalpriprou' OR
      subsection_id IN(#{ SurveyResponse.total_excluded_subsection_ids(strategy) })
      SQL
    ).pluck(:id)
  end

  def self.total_excluded_question_ids_string(strategy=:policy)
    total_excluded_question_ids_array(strategy).
    inject {|memo, obj| memo.to_s + ', ' + obj.to_s  }
  end

  def self.total_excluded_subsection_ids(strategy=:policy)
    Subsection.where( title: SALARY_TOTALS_SUBSECTIONS[strategy] ).
    pluck(:id).
    inject {|memo, obj| memo.to_s + ', ' + obj.to_s  }
  end

private
  def sync_values
    ResponseValue.sync_survey_response self
  end
end
