class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  belongs_to :survey_response, inverse_of: :questions
  belongs_to :validation_type, inverse_of: :questions
  belongs_to :subsection, inverse_of: :questions
  has_many :options, inverse_of: :question
  has_many :values, inverse_of: :question, class_name: 'ResponseValue'

  def field_type
    if data_type == 'integer' || data_type == 'string' || data_type == 'decimal'
      input = 'input'
    else
      input = data_type
    end

    "#{input}#{question_type.blank? ? '' : '_'+question_type }"
  end

# legacy?
  def election_profile?
    false
  end
 
  def comment?
    question_type == 'comment'
  end

  def salary?
    cost_type == 'salaries'
  end

  def service_supply?
    cost_type == 'services & supplies'
  end
end
