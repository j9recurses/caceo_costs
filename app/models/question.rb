class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  belongs_to :validation_type, inverse_of: :questions
  belongs_to :subsection, inverse_of: :questions


  # uses response model
  def data_type
    @data_type ||= survey.response_type.constantize.column_types[ self.field ].type
  end

  def na?

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
