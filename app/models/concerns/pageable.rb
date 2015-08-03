module Pageable
  def pages
    @pages ||= questions.to_a.compact.in_groups_of(12, false)
  end

  def total_steps
    pages.size
  end

  def current_step
    @current_step ||= 0
  end

  def current_step=(page)
    @current_step = page.to_i
  end

  def current_page
    pages[current_step]
  end

  def step_forward
    unless current_step == (total_steps - 1)
      self.current_step = current_step + 1
    end
  end

  def step_back
    unless current_step == 0
      self.current_step = current_step - 1
    end
  end

  def last_step?
    current_step == (total_steps - 1)
  end

  def first_step?
    current_step == 0
  end
end
