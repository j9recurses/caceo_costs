class Activity
  class << self
    def all
      SurveyResponse.order(updated_at: :desc).
        joins(:survey, :county, :election).
        select(<<-SQL)
          election_years.year AS election_name,
          surveys.title AS survey_title,
          surveys.category AS survey_category,
          counties.name AS county_name,
          survey_responses.updated_at AS updated_at
        SQL
    end

    def summary
      all.group(:survey_category, :county_name, :election_name)
      .select('COUNT(surveys.category) AS category_count, MAX(survey_responses.updated_at) as last_updated')
    end

    def today
      summary.where('survey_responses.updated_at >= ?', day_begin)
    end

    def last_week
      summary.where(
        'survey_responses.updated_at >= ? AND survey_responses.updated_at < ?', 
        week_begin, day_begin )
    end

    def last_month
      summary.where(
        'survey_responses.updated_at >= ? AND survey_responses.updated_at < ?', 
        month_begin, week_begin )
    end

    def all_prior
      summary.where('survey_responses.updated_at < ?', month_begin)
    end

    def day_begin
      Time.now.in_time_zone(Time.zone).midnight
    end

    def week_begin
      8.days.ago.midnight
    end

    def month_begin
      39.days.ago.midnight
    end
  end
end