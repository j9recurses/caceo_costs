class QuestionResponse
  def initialize(response_instance)
    @response_instance = response_instance
  end
  attr_accessor :response_instance

  def na
    @na ||= Na.new
  end

  # ( should this just be a method on question ? )
  def na?( question )
    response_instance.send( question.field ) == na.for( question.data_type )
  end
end