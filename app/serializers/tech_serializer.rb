class TechSerializer
  include Enumerable

  def initialize(tech_klass, query)
    @klass = tech_klass
    @query = query
    @fields = tech_klass.column_names - ['id', 'created_at', 'updated_at', 'county_id']
  end
  attr_reader :klass, :fields, :query

  def each
    klass.where.not(county_id:59).where(query).find_each do |row|
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
    if obj.class.column_types[field].type == :boolean
      b_val = obj.send field
      b_val == true ? 1 : 0
    else
      obj.send field
    end
  end
end
