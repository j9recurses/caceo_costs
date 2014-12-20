class CategoryDescription < ActiveRecord::Base
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
