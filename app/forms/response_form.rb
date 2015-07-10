class ResponseForm
  def self.new(obj)
    ResponseFormBuilder.build(obj)
  end
end

class ResponseFormBuilder
  def initialize(response_obj)
    @response_instance = response_obj
    @response_name = response_obj.class.to_s
    @klass = Class.new(Reform::Form)
    @klass.class_eval <<-RUBY
      property :county_id
      property :election_year_id
      #{property_list(@response_name)}
    RUBY
  end
  attr_accessor :klass, :response_name

  def property_list(survey_name)
    @properties = ""
    Survey.find(survey_name).questions.each do |q|
      @properties = @properties + "property :" + q.field + "\n"
      if q.na_able?
        @properties = @properties + "property :" + q.na_field + "\n"
      end
    end
    @properties
  end

  def self.build(response_inst)
    new(response_inst).klass.new(response_inst)
  end
end