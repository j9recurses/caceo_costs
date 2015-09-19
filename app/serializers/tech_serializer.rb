class TechSerializer
  include Enumerable

  def initialize(tech_klass)
    @klass = tech_klass
    @fields = tech_klass.column_names - ['id', 'created_at', 'updated_at', 'county_id']
  end
  attr_reader :klass, :fields

  def each
    klass.find_each do |row|
      fields.each do |field|
        yield TechResponseValue.new(row, field)
      end
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
end
