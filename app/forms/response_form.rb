class ResponseForm
  def self.new(obj)
    ResponseFormBuilder.build(obj)
  end
end

class ResponseFormBuilder
  def initialize(response_obj)
    @response_instance = response_obj
    @survey_id = response_obj.class.to_s
    @klass = Class.new(Reform::Form)

    @klass.class_eval <<-RUBY
      property :county_id
      property :election_year_id
      #{property_list(@survey_id)}
      #{virtual_bit_mask_property_list}

      def self.bit_mask_fields() #{ bit_mask_fields } end
      def self.survey_id() #{ @survey_id } end
      include BitMaskable
    RUBY
  end
  attr_accessor :klass, :survey_id

  # BUILDER Class method
  def self.build(response_inst)
    new(response_inst).klass.new(response_inst)
  end

  # BUILDER Instance method
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

  # BUILDER Instance method
  def bit_mask_fields
    @bit_mask_fields ||= Question.where(
      survey_id: @survey_id, 
      question_type: 'multi_select'
    ).pluck(:field)
  end

  # BUILDER Instance method
  def virtual_bit_mask_property_list
    bit_mask_properties = ""
    bit_mask_fields.each do |field|
      prop = "property :#{field}_multi_select, virtual: true \n"
      bit_mask_properties = bit_mask_properties + prop
    end
    bit_mask_properties
  end
end
