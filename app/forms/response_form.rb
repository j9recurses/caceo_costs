class ResponseForm
  def initialize(response_name)
    @response_name = response_name
    @mod = Module.new
    @mod.class_eval <<-RUBY
      include Reform::Form::Module 
        property :response do
          property :county_id
          property :election_year_id
          #{property_list(@response_name)}
        end
      RUBY
  end
  attr_accessor :mod, :response_name

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

  def self.build(response_name)
    new(response_name).mod
  end
end
