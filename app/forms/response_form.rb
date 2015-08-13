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

      #{properties_with_validations(@survey_id)}
      #{bit_mask_property_list}
      
      # for bit mask mixins
      def self.questions
        @questions ||= Question.where(survey_id: #{ @survey_id })
      end
      include BitMaskable
      ## include BitMaskReadable
      ## include BitMaskWriteable
    RUBY
  end
  attr_accessor :klass, :survey_id

  TYPE_VALIDATE = {
    'integer' => <<-RUBY,
      numericality: { only_integer: true,  greater_than_or_equal_to: 0, less_than: 2147483647, allow_blank: true }
      RUBY
    'decimal' => <<-RUBY,
      numericality: { less_than_or_equal_to: 9.99, greater_than_or_equal_to: 0.01, allow_blank: true }
      RUBY
    'text'    => nil,
    'string'  => nil,
    'boolean' => nil
  }

  FIELD_VALIDATE = {
    'epicrp' => <<-RUBY
      numericality: { less_than_or_equal_to: 9999.99, greater_than_or_equal_to: 0.01, allow_blank: true }
    RUBY
  }

  # BUILDER Class method
  def self.build(response_inst)
    new(response_inst).klass.new(response_inst)
  end

  def properties_with_validations(survey_name)
    list = ''
    Survey.find(survey_name).questions.each do |q|
      prop = "property :#{q.field}\n"
      na = q.na_able? ? "property :#{q.na_field}\n" : ''
      validation = if FIELD_VALIDATE[q.field]
        "validates :#{q.field}, #{FIELD_VALIDATE[q.field]}\n"
      elsif TYPE_VALIDATE[q.data_type]
        "validates :#{q.field}, #{TYPE_VALIDATE[q.data_type]}\n"
      else '' end

      list << prop << na << validation
    end
    list
  end

  def bit_mask_property_list
    bit_mask_properties = ""
    bit_mask_fields.each do |field|
      prop = "property :#{field}_multi_select, writeable: false \n"
      bit_mask_properties = bit_mask_properties + prop
    end
    bit_mask_properties
  end

  def bit_mask_fields
    # atm new responses have nil associations - through sr
    # @response_instance.questions.multi_select.pluck(:field)
    Question.where(
      survey_id: @survey_id, 
      question_type: 'multi_select'
    ).pluck(:field)
  end
end
