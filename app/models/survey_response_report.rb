class SurveyResponseReport
  def self.sr_overview_query
    <<-SQL
      SELECT 
        sr.response_id,
        sr.election_id,
        sr.county_id,
        sr.id             AS survey_response_id,
        sr.response_type  AS survey_id,
        e.election_dt     AS election_date,
        e.name            AS election_name,
        c.name            AS county_name,
        s.title           AS survey_title,
        COUNT(rv.id)      AS _answered, 
        COUNT(q.id)       AS _total_questions, 
        SUM(rvt.integer_value) AS _total
      FROM survey_responses sr
      INNER JOIN surveys s
      ON sr.response_type = s.id
      INNER JOIN elections e
      ON sr.election_id = e.id
      INNER JOIN (
        SELECT c.id, c.name 
        FROM counties c
        WHERE name NOT LIKE '%Test%') c
      ON sr.county_id = c.id
      INNER JOIN questions q
      ON q.survey_id = sr.response_type
      LEFT JOIN (
        SELECT rv.id, rv.integer_value, rv.survey_response_id, rv.question_id
        FROM response_values rv
        WHERE NOT(
          rv.integer_value IS NULL AND
          rv.decimal_value IS NULL AND
          rv.string_value  IS NULL AND
          rv.text_value    IS NULL AND
          rv.boolean_value IS NULL AND
          rv.na_value = 0
        )
      ) rv
      ON rv.survey_response_id = sr.id AND rv.question_id = q.id
      LEFT JOIN ( SELECT rvt.id, rvt.integer_value, rvt.na_value, rvt.survey_response_id, rvt.question_id
        FROM response_values rvt
        WHERE rvt.integer_value IS NOT NULL
        ) rvt
      ON rvt.id = rv.id AND 
        q.data_type = "integer" AND
        q.sum_able  = true      AND
        (q.na_able  = false OR rvt.na_value = 0) 
      GROUP BY sr.id
      ORDER BY sr.county_id ASC, sr.response_type ASC, e.election_dt ASC
    SQL
  end

  def self.sr_overview
    @progress_view ||= SurveyResponse.find_by_sql( sr_overview_query )
  end

  def self.progress_hash
    @progress_hash = {}
    self.sr_overview.each do |e|
      @progress_hash[[e.county_name, e.survey_title, e.election_name]] = (
        (e._answered / e._total_questions.to_f).round(2) * 100).to_i
    end
    @progress_hash
  end

  def self.progress_array
    result = []
    hash = self.progress_hash
    election_names = Election.order(election_dt: :asc).pluck(:name)
    survey_titles = Survey.order(id: :asc).pluck(:title)

    County.where("name NOT LIKE '%Test%'").order(id: :asc).pluck(:name).each do |c_name|
      county_array = []
      survey_titles.each do |s_title|
        survey_result = [s_title]
        election_names.each do |e_name|
          survey_result.push hash[[c_name, s_title, e_name]]
        end
        county_array.push(survey_result)
      end
      result.push({c_name => county_array})
    end
    result
  end
end
