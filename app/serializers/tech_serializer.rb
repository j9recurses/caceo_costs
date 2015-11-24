class TechSerializer
  include Enumerable

  def initialize(tech_relation)
    @relation = tech_relation
    @klass = tech_relation.first.class
    @fields = @klass.column_names - ['id', 'created_at', 'updated_at', 'county_id']
  end
  attr_reader :relation, :klass, :fields

  def each
    relation.each do |row|
      fields.each do |field|
        yield TechResponseValue.new(row, field)
      end
    end
  end

  def answered_count
    @answered_count ||= inject(0) do |memo, v| 
      v.answered? ? memo = memo + 1 : memo
    end
  end
end


class TechResponseValue
  def initialize(tech_obj, field)
    @obj = tech_obj
    @field = field
  end
  attr_reader :obj, :field

  def county_id
    obj.county_id
  end

  def election_code
    nil
  end

  def survey_code
    obj.class.to_s
  end

  def value
    obj.send field
  end

  def answered?
    !value.blank? || value.is_a?(FalseClass)
  end

  def data_value
    if obj.class.column_types[field].type == :boolean
      b_val = obj.send field
      b_val == true ? 1 : 0
    else
      value
    end
  end
end
