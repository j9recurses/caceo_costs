class ResponseValue < ActiveRecord::Base
  belongs_to :survey_response, inverse_of: :values
  belongs_to :question, inverse_of: :values

  def self.sync_survey_response_question(survey_response, question)
    val = ResponseValue.find_by(survey_response: survey_response, question: question)
    unless val
      val = ResponseValue.new(survey_response: survey_response, question: question)
    end

    resp = survey_response.response
    # set na_value and data_type_value
    if question.na_able?
      val.na_value = resp[question.na_field]
    end
    val.send(question.data_type + '_value=', resp[question.field])
    # clear all other value fields
    Question.pluck(:data_type).uniq.reject { |d| d == question.data_type }.each do |dt|
      val.send( dt + '_value=', nil)
    end
    # save only if we changed it
    persisted_val = ResponseValue.
      where( survey_response: val.survey_response, question: val.question).first
    val.save! unless persisted_val && persisted_val.attributes.values == val.attributes.values
    # raise
  end

  def self.sync_survey_response(survey_response)
    raise 'SurveyResponse has no Response present' unless survey_response.response
    success = false
    survey_response.questions.each do |q|
      sync_survey_response_question survey_response, q
    end
    true #else sync_survey_response_question should raise error
  end

  def self.total
    joins(:question, :survey_response)
      .where('sum_able = true AND (na_able = false OR na_value = false) AND questions.data_type = "integer"')
      .sum(:integer_value)
  end

  def self.answered_ratio
    (answered.to_f / count.to_f).round(2)
  end

  def self.percent_answered
    (self.answered_ratio * 100).to_i
  end

  def self.answered
    # where(answered: true).count
    where(<<-SQL 
      NOT(
      integer_value IS NULL AND
      decimal_value IS NULL AND
      string_value  IS NULL AND
      text_value    IS NULL AND
      boolean_value IS NULL AND
      na_value = 0)
      SQL
      )
    .count
  end

  def answered?
    if integer_value == nil &&
      decimal_value == nil &&
      string_value == nil &&
      text_value == nil &&
      boolean_value == nil &&
      na_value == false
      false
    else
      true
    end
  end
end
