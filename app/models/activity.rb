class Activity
  SURVEYS = [ElectionProfile, Postage, Salbal, Salbc, Salcan, Saldojo, Salmed, Saloth, Salpp, Salpw, Salvbm, Ssbal, Ssbc, Sscan, Ssmed, Ssoth, Sspp, Sspw, Ssveh]
  TECH_SURVEYS = [TechVotingMachine, TechVotingSoftware]
  COUNTY_IDS = Array(1..58)
  # def initialize()
  #   @relation = relation
  # end

  def self.since(time)
    result = []
    SURVEYS.each do |klass|
      model_name = klass.to_s.underscore.pluralize
      relation = Activity.query(klass).where("#{model_name}.updated_at > ?", time)
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
    model_name = klass.to_s.underscore.pluralize
    election_model       = klass == ElectionProfile ? 'election_year_profiles'   : 'election_years'
    election_foreign_key = klass == ElectionProfile ? 'election_year_profile_id' : 'election_year_id' 

    relation = klass.select("MAX(#{model_name}.id) AS id, '#{model_name}' AS model_name, county, #{model_name}.updated_at")
      .where.not(county: 59)
      .group(:county, election_foreign_key.to_sym)

    unless klass == TechVotingMachine || klass == TechVotingSoftware
      relation = relation.select("#{election_model}.year AS election_name, #{election_model}.election_dt AS election_date")
      .joins("INNER JOIN #{election_model} ON #{election_model}.id = #{model_name}.#{election_foreign_key}")
    end

    if klass != ElectionProfile
      relation = relation.select("category_descriptions.name AS survey_name")
      .joins("INNER JOIN category_descriptions ON category_descriptions.model_name = '#{model_name}'")
    else
      relation = relation.select("'Election Profile' AS survey_name")
    end
  end

  def self.tech_query(klass)
    model_name = klass.to_s.underscore.pluralize
    relation = klass.select("MAX(#{model_name}.id) AS id, '#{model_name}' AS model_name, county, #{model_name}.updated_at")
      .where.not(county: 59)
      .select("ca_county_infos.name AS county_name, #{model_name}.*")
      .joins("INNER JOIN ca_county_infos on ca_county_infos.id = #{model_name}.county")
  end

  def self.county_query(id)
    result = []
    SURVEYS.each do |klass|
      model_name = klass.to_s.underscore.pluralize
      election_model       = klass == ElectionProfile ? 'election_year_profiles'   : 'election_years'
      election_foreign_key = klass == ElectionProfile ? 'election_year_profile_id' : 'election_year_id' 

      relation = klass.where(county: id)      
        .select("#{model_name}.*, #{election_model}.year AS election_name, #{election_model}.election_dt AS election_date")
        .joins("INNER JOIN #{election_model} ON #{election_model}.id = #{model_name}.#{election_foreign_key}")
      
      if klass != ElectionProfile
        survey_name = CategoryDescription.where("model_name = '#{model_name}'").limit(1).first.name
        # relation.select("category_descriptions.name AS survey_name")
        # .joins("INNER JOIN category_descriptions ON category_descriptions.model_name = '#{model_name}'")
      else
        survey_name = 'Election Profile'
        # relation = relation.select("'Election Profile' AS survey_name")
      end

      result.push( { survey_name => relation })
    end
    { CaCountyInfo.find(id).name => result }
  end

      # relation = klass.where(county: id).select("ca_county_infos.name AS county_name").select("#{model_name}.*, #{election_model}.year AS election_name, #{election_model}.election_dt AS election_date").joins("INNER JOIN #{election_model} ON #{election_model}.id = #{model_name}.#{election_foreign_key}").joins("INNER JOIN ca_county_infos on ca_county_infos.id = #{model_name}.county")
        
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
    model_name = klass.to_s.underscore.pluralize
    Activity.query(klass)
      .select("ca_county_infos.name AS county_name, #{model_name}.*")
      .joins("INNER JOIN ca_county_infos on ca_county_infos.id = #{model_name}.county")
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