class FormPages
  def initialize(survey)
    @questions = survey.questions
    @pages = @questions.to_a.compact.in_groups_of(12, false)
  end

  def total_steps
    @pages.size - 1
  end

  def current_step
    @current_step ||= 0
  end

  def current_step=(step)
    @current_step = step.to_i
  end

  def step_forward
    self.current_step = self.current_step + 1
  end

  def step_back
    self.current_step = self.current_step - 1
  end

  def last_step?
    current_step == total_steps
  end

  def first_step?
    current_step == 0
  end

  def method_missing(method_name, *args, &block)
    if /^step(\d+)\?$/ =~ method_name
      step?($1.to_i)
    else
      super
    end
  end
end
