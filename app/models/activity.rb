class Activity
  SURVEYS = [Postage, Salbal, Salbc, Salcan, Saldojo, Salmed, Saloth, Salpp, Salpw, Salvbm, Ssbal, Ssbc, Sscan, Ssmed, Ssoth, Sspp, Sspw, Ssveh]

  def self.since(time)
    result = []
    SURVEYS.each do |klass|
      model_name = klass.to_s.downcase.pluralize
      result.concat klass.select("MAX(#{model_name}.id) AS id, '#{model_name}' AS model_name, county, #{model_name}.updated_at, election_years.year AS election_name, election_years.election_dt AS election_date, category_descriptions.name AS survey_name")
        .where.not(county: 59)
        .where("#{model_name}.updated_at > ?", time)
        .group(:county, :election_year_id)
        .joins("INNER JOIN election_years ON election_years.id = #{model_name}.election_year_id")
        .joins("INNER JOIN category_descriptions ON category_descriptions.model_name = '#{model_name}'")
    end
    result
  end

  def self.all
    result = []
    SURVEYS.each do |klass|
      model_name = klass.to_s.downcase.pluralize
      result.concat klass.select("MAX(#{model_name}.id) AS id, '#{model_name}' AS model_name, county, #{model_name}.updated_at, election_years.year AS election_name, election_years.election_dt AS election_date, category_descriptions.name AS survey_name")
        .where.not(county: 59)
        .group(:county, :election_year_id)
        .joins("INNER JOIN election_years ON election_years.id = #{model_name}.election_year_id")
        .joins("INNER JOIN category_descriptions ON category_descriptions.model_name = '#{model_name}'")
    end
    result
  end

  def self.sort_by_county_election(array)
    county_array = array.sort { |x,y| x.county <=> y.county }
    grouped = county_array.group_by { |x| x.county }

    grouped.map do |county_id, surveys|
      sorted_surveys = surveys.sort {|x,y| y.election_date <=> x.election_date } 
      survey_hash = sorted_surveys.group_by { |x| x.election_name }
      survey_hash.each do |elec, survs|
        survey_hash[elec] = survs.sort {|x,y| y.updated_at <=> x.updated_at }
      end

      { county_name: CaCountyInfo.find(county_id).name,
        elections: survey_hash }
    end
  end
end