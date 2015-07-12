class SurveySql
  def initialize(survey_klass)
    @survey = survey_klass
  end
  attr_accessor :survey

  # turns out it's not necessary
  def delete_election_profile_query
    <<-SQL
    DELETE election_profiles
    FROM election_profiles
    INNER JOIN
    (
      SELECT MAX(id) id, county_id, election_year_profile_id
        FROM election_profiles
       GROUP BY county_id, election_year_profile_id
    ) d
    ON  d.county_id = election_profiles.county_id
    AND d.election_year_profile_id = election_profiles.election_year_profile_id
    AND d.id <> election_profiles.id;
    SQL
  end

  def delete_direct_cost_query
    <<-SQL
    DELETE year_elements, #{table_name}
    FROM #{table_name}
    LEFT JOIN year_elements ON year_elements.element_id = #{table_name}.id
    INNER JOIN
    (
      SELECT MAX(id) id, county_id, election_year_id
        FROM #{table_name}
       GROUP BY county_id, election_year_id
    ) d
    ON  d.county_id = #{table_name}.county_id
    AND d.election_year_id = #{table_name}.election_year_id
    AND d.id <> #{table_name}.id;
    SQL
  end

  def delete_direct_cost_query_ignore_year_elements
    <<-SQL
    DELETE #{table_name}
    FROM #{table_name}
    INNER JOIN
    (
      SELECT MAX(id) id, county_id, election_year_id
        FROM #{table_name}
       GROUP BY county_id, election_year_id
    ) d
    ON  d.county_id = #{table_name}.county_id
    AND d.election_year_id = #{table_name}.election_year_id
    AND d.id <> #{table_name}.id;
    SQL
  end

  def delete_dups(year_elements: false, election_profile: false)
    initial_maxid = cat_maxid
    if year_elements
      ActiveRecord::Base.connection.execute(delete_direct_cost_query)
    elsif election_profile
      ActiveRecord::Base.connection.execute(delete_election_profile_query)
    else
      ActiveRecord::Base.connection.execute(delete_direct_cost_query_ignore_year_elements)
    end
    final_count = cat_count
    final_maxid = cat_maxid
    if final_count.values.all? { |v| v == 1 } && final_maxid.values == initial_maxid.values
      true
    else
      false
    end
  end

  def cat_maxid
    if survey == ElectionProfile
      survey.group(:county_id, :election_year_profile_id).maximum(:id)
    else
      survey.group(:county_id, :election_year_id).maximum(:id)
    end
  end

  def cat_count
    if survey == ElectionProfile
      survey.group(:county_id, :election_year_profile_id).count
    else
      survey.group(:county_id, :election_year_id).count
    end
  end

  def print_cat
    puts cat_status
  end

  def cat_status
    "#{survey.to_s} MAXIDS: #{cat_maxid} \n#{survey.to_s} COUNTS: #{cat_count}"
  end

  def table_name
    survey.model_name.plural
  end
end