class Activity
  def self.all
    SurveyResponse.order(updated_at: :desc).
      joins(:survey, :county, :election).
      select(<<-SQL)
        election_years.year AS election_year, 
        surveys.title AS survey_title, 
        counties.name AS county_name,
        survey_responses.updated_at AS updated_at
      SQL
  end
end