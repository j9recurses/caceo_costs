module MultiStepModel

  def current_step
    @current_step ||= 0
  end

  def current_step=(step)
    @current_step = step.to_i
  end

  def current_step_valid?
    valid?
  end

  def step_forward
    self.current_step = self.current_step + 1
    puts "current_step stepped forward: #{current_step}"
  end

  def step_back
    self.current_step = self.current_step - 1
  end

  def last_step?
    current_step == total_steps
  end

  def total_steps
    if self.class == ElectionProfile
      ElectionProfileDescription.where(model_name: 'election_profiles').in_groups_of(16).size - 1
    else
      @total_steps ||= CategoryDescription.where(model_name: "#{self.class.to_s.downcase}s" ).where.not('label LIKE "%Percent%" AND model_name != "salbals"').in_groups_of(12).size - 1
    end
  end

  def first_step?
    current_step == 0
  end
  
  def all_steps_valid?
    valid?
    # (0...self.class.total_steps).all? do |step|
    #   @current_step = step
    #   current_step_valid?
    # end
  end

  def some_steps_valid?
    valid?
    # @onthisstep = @current_step.to_i
    # (0..@onthisstep).all? do |step|
    #   @current_step = step
    #   current_step_valid?
    # end
  end

  def method_missing(method_name, *args, &block)
    if /^step(\d+)\?$/ =~ method_name
      step?($1.to_i)
    else
      super
    end
  end
end
