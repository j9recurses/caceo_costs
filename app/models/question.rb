class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  belongs_to :survey_response, inverse_of: :questions
  belongs_to :validation_type, inverse_of: :questions
  belongs_to :subsection, inverse_of: :questions
  has_many :options, inverse_of: :question
  has_many :values, inverse_of: :question, class_name: 'ResponseValue'

  scope :multi_select, -> { where(question_type: 'multi_select') }
  scope :no_mask, ->  { where("question_type <> 'multi_select' OR question_type IS NULL") }

  def multi_select?
    question_type == 'multi_select'
  end

  def boolean?
    data_type == 'boolean'
  end

  def multi_select_field
    field + '_multi_select'
  end

########### legacy? 
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
