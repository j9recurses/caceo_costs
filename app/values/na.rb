class Na
  NA_VALUES = { integer: -1, decimal: -1.0, string: 'NOT_APPLICABLE', text: 'NOT_APPLICABLE', boolean: nil }
  PARAM_NA_VALUES = { integer: "-1", decimal: "-1.0", string: 'NOT_APPLICABLE', text: 'NOT_APPLICABLE', boolean: "" }

  def for( data_type )
    NA_VALUES[ data_type.to_sym ]
  end

  def param_for( data_type )
    PARAM_NA_VALUES[ data_type ]
  end
end