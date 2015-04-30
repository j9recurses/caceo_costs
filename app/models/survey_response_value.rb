class SurveyResponseValue < ActiveRecord::Base
  belongs_to :survey_response, inverse_of: :values
  belongs_to :question, inverse_of: :values

  def self.total
    joins(:question, :survey_response)
      .where('sum_able = true AND (na_able = false OR na_value = false) AND questions.data_type = "integer"')
      .sum(:integer_value)
  end

  def self.percent_answered
    answered_questions.to_f / count
  end

  def self.answered_questions
    where(answered: true).count
  end

  def self.questions_count
    count
  end
end
