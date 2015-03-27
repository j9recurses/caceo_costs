class Activity
  SURVEYS = [ElectionProfile, Postage, Salbal, Salbc, Salcan, Saldojo, Salmed, Saloth, Salpp, Salpw, Salvbm, Ssbal, Ssbc, Sscan, Ssmed, Ssoth, Sspp, Sspw, Ssveh]
  TECH_SURVEYS = [TechVotingMachine, TechVotingSoftware]
  COUNTY_IDS = Array(1..58)

  def self.since(time)
    result = []
    SURVEYS.each do |klass|
      table_name = klass.to_s.underscore.pluralize
      relation = Activity.query(klass).where("#{table_name}.updated_at > ?", time)
      result.concat relation
    end
    result
  end

  def self.all
    result = []
    SURVEYS.each do |klass|
      result.concat Activity.query(klass)
    end
    result
  end

  def self.query(klass)
    table_name = klass.to_s.underscore.pluralize
    election_model       = klass == ElectionProfile ? 'election_year_profiles'   : 'election_years'
    election_foreign_key = klass == ElectionProfile ? 'election_year_profile_id' : 'election_year_id' 

    relation = klass.select("MAX(#{table_name}.id) AS id, '#{table_name}' AS table_name, county_id, #{table_name}.updated_at")
      .where.not(county_id: 59)
      .group(:county_id, election_foreign_key.to_sym)

    unless klass == TechVotingMachine || klass == TechVotingSoftware
      relation = relation.select("#{election_model}.year AS election_name, #{election_model}.election_dt AS election_date")
      .joins("INNER JOIN #{election_model} ON #{election_model}.id = #{table_name}.#{election_foreign_key}")
    end

    if klass != ElectionProfile
      relation = relation.select("questions.name AS survey_name")
      .joins("INNER JOIN questions ON questions.table_name = '#{table_name}'")
    else
      relation = relation.select("'Election Profile' AS survey_name")
    end
  end

# maintain 'county' not county_id
  def self.tech_query(klass)
    table_name = klass.to_s.underscore.pluralize
    relation = klass.select("MAX(#{table_name}.id) AS id, '#{table_name}' AS table_name, county, #{table_name}.updated_at")
      .where.not(county: 59)
      .select("counties.name AS county_name, #{table_name}.*")
      .joins("INNER JOIN counties on counties.id = #{table_name}.county")
  end

  def self.county_query(id)
    result = []
    SURVEYS.each do |klass|
      table_name = klass.to_s.underscore.pluralize
      election_model       = klass == ElectionProfile ? 'election_year_profiles'   : 'election_years'
      election_foreign_key = klass == ElectionProfile ? 'election_year_profile_id' : 'election_year_id' 

      relation = klass.where(county_id: id)      
        .select("#{table_name}.*, #{election_model}.year AS election_name, #{election_model}.election_dt AS election_date")
        .joins("INNER JOIN #{election_model} ON #{election_model}.id = #{table_name}.#{election_foreign_key}")
      
      if klass != ElectionProfile
        survey_name = Question.where("table_name = '#{table_name}'").limit(1).first.name
      else
        survey_name = 'Election Profile'
      end
      result.push( { survey_name => relation } )
    end
    { County.find(id).name => result }
  end
      # relation = klass.where(county_id: id).select("counties.name AS county_name").select("#{table_name}.*, #{election_model}.year AS election_name, #{election_model}.election_dt AS election_date").joins("INNER JOIN #{election_model} ON #{election_model}.id = #{table_name}.#{election_foreign_key}").joins("INNER JOIN counties on counties.id = #{table_name}.county_id")
        
  def self.elections
    ElectionYear.order(election_dt: :asc).pluck(:year)
  end

  def self.county_report
    result = []
    COUNTY_IDS.each do |id|
      county_array = Activity.county_query(id)
      result.push county_array
    end
    result
  end

  def self.report(klass)
    table_name = klass.to_s.underscore.pluralize
    Activity.query(klass)
      .select("counties.name AS county_name, #{table_name}.*")
      .joins("INNER JOIN counties on counties.id = #{table_name}.county_id")
  end

  def self.report_tech
    result = []
    TECH_SURVEYS.each do |klass|
      result.push Activity.tech_query(klass)
    end
    result
  end

  def self.report_all
    result = []
    SURVEYS.each do |klass|
      result.push Activity.report(klass)
    end
    result
  end

  def self.sort_by_county_election(array)
    county_array = array.sort { |x,y| x.county_id <=> y.county_id }
    grouped = county_array.group_by { |x| x.county_id }

    grouped.map do |county_id, surveys|
      sorted_surveys = surveys.sort {|x,y| y.election_date <=> x.election_date } 
      survey_hash = sorted_surveys.group_by { |x| x.election_name }
      survey_hash.each do |elec, survs|
        survey_hash[elec] = survs.sort {|x,y| y.updated_at <=> x.updated_at }
      end

      { county_name: County.find(county_id).name,
        elections: survey_hash }
    end
  end
end