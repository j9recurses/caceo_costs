class ResponseValue < ActiveRecord::Base
  belongs_to :survey_response, inverse_of: :values
  belongs_to :question, inverse_of: :values
  has_one :election, through: :survey_response, class_name: 'ElectionYear'
  has_one :county, through: :survey_response
  has_one :survey, through: :survey_response

  def data_types
    ['integer', 'text', 'decimal', 'string', 'boolean']
  end

  def set_off_values_to_nil
    ( data_types - [question.data_type] ).each do |d_type|
      send( "#{d_type}_value=", nil)
    end
  end

  def set_na_value
    if question.na_able?
      self.na_value = response[question.na_field]
    end
  end

  def set_data_type_value
    send(question.data_type + '_value=', response[question.field])
  end

  def response
    survey_response.response
  end

  def sync!
    raise 'SurveyResponse, Question not associated' unless survey_response && question
    set_na_value
    set_data_type_value
    set_off_values_to_nil

    persisted_v = ResponseValue.find_by( survey_response: survey_response,
      question: question)
    save! unless persisted_v && persisted_v.attributes.values == attributes.values
  end

  def self.sync_survey_response(survey_response)
    raise 'Response not associated' unless survey_response.response
    transaction do
      survey_response.questions.each do |q|
        v = find_by(survey_response: survey_response, question: q)
        v ||= new(  survey_response: survey_response, question: q)
        v.sync! # responsible for throwing error
      end
    end
    true
  end

  def self.total
    joins(:question, :survey_response)
      .where(<<-SQL
        sum_able = true
        AND (na_able = false OR na_value = false)
        AND questions.data_type = "integer"
      SQL
      ).sum(:integer_value)
  end

  def self.answered_ratio
    rat = (answered.to_f / count.to_f).round(2)
    rat.nan? ? 0 : rat
  end

  def self.percent_answered
    (self.answered_ratio * 100).to_i
  end

  def self.answered
    joins(<<-SQL
      INNER JOIN questions q
      ON question_id = q.id
      AND ( q.question_type != 'comment'
        OR  q.question_type IS NULL )
      SQL
    ).where(<<-SQL
      NOT(
      integer_value IS NULL AND
      decimal_value IS NULL AND
      string_value  IS NULL AND
      text_value    IS NULL AND
      boolean_value IS NULL AND
      na_value = 0 )
      SQL
      )
    .count
  end

  def answered?
    if integer_value  == nil &&
      decimal_value   == nil &&
      string_value    == nil &&
      text_value      == nil &&
      boolean_value   == nil &&
      na_value == false      &&
      question.question_type != 'comment'
      false
    else
      true
    end
  end

  def value_field
    question.data_type + '_value'
  end

  def value
    if question.na_able? && na_value
      "N/A"
    elsif question.multi_select?
      survey_response.response.send( question.field + '_multi_select').join(', ')
    else
      send value_field
    end
  end

  def data_value
    if question.data_type == 'boolean'
      b_val = send value_field
      b_val == true ? 1 : 0
    else
      value
    end
  end
end
