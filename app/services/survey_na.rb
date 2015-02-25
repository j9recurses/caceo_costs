require "#{Rails.root}/app/values/na"

class SurveyNa
  NA_VALUES = { integer: -1, decimal: -1.0, string: 'NOT_APPLICABLE', text: 'NOT_APPLICABLE', boolean: nil }

  def initialize(session, params)
    @session = session
    @params = params
  end
  attr_accessor :session, :params

  def merged_session(empty_not_applicable:false)
    @merged_session ||= case empty_not_applicable
    when :params
      @session.deep_merge! coerce_to_columns( empty_as_na(@params) )
    when :session
      @session.deep_merge! coerce_to_columns( empty_as_na(@params) )
      empty_as_na(@session)
    else
      @session.deep_merge! merged_params
    end
  end

  def na_params
    @na_params ||= @params.select do |k,v|
      k.match(/_na$/) && v == "1"
    end
  end

  def na_columns
    @na_columns ||= na_params.map do |pair|
      pair[0].match(/(.*)_na$|_value$/)[1]
    end
  end

  def coerced_params
    @coerced_params ||= coerce_to_columns(@params)
  end

  # deletes _na fields, rewrites _value keys to field name
  # does not currently check against model or whitelist
  def coerce_to_columns(hash)
    hash.transform_keys { |key|
      match = key.match /(.*)_value$/
      if match
        match[1]
      else
        key
      end
    }.reject do |k,v|
      k.match /_na$/
    end
  end


  def empty_as_na(hash)
    puts hash
    h = hash.map do |k,v|
      if ( k.match(/(_value$|[^(_na$)])/) || ElectionProfile.questions.find_by(field: k).na_able? ) && v.empty?
        [k, Na.new.param_for( ElectionProfile.column_types[k].type ) ]
      else
        [k, v]
      end
    end
    Hash[h]
  end

  def merged_params
    na_columns.each do |field_name|
      @params["#{field_name}_value"] = Na.new.param_for( ElectionProfile.column_types[field_name].type )
    end
    coerced_params
  end
end