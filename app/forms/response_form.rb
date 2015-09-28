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
      #{properties_with_validations(@survey_id)}
      #{bit_mask_property_list}
    RUBY
  end
  attr_accessor :klass, :survey_id

  # BUILDER Class method
  def self.build(response_inst)
    new(response_inst).klass.new(response_inst)
  end

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

  def properties_with_validations(survey_name)
    survey_questions.no_mask.map { |q|
      "property :#{q.field}\n" +
      property_na(q) +
      property_validation(q)
    }.join
  end

  def bit_mask_property_list
    survey_questions.multi_select.map { |q|
      "property :#{q.field}_multi_select\n" +
      property_na(q)
      # property_validation(q)
    }.join
  end

  def property_na(q)
    if q.na_able?
      "property :#{q.na_field}\n"
    else
      ''
    end
  end

  def property_validation(q)
    validation = if FIELD_VALIDATE[q.field]
      "validates :#{q.field}, #{FIELD_VALIDATE[q.field]}\n"
    elsif TYPE_VALIDATE[q.data_type]
      "validates :#{q.field}, #{TYPE_VALIDATE[q.data_type]}\n"
    else '' end
  end

  def survey_questions
    @response_instance.questions
  end
end
