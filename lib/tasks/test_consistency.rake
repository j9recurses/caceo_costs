namespace :caceo do
  desc "Ensure that all SurveyResponses match county/election with their Responses"
  task response_assoc: :environment do
    response_types = GeneralSurvey::DIRECT_COST_SURVEYS
    response_types.push(ElectionProfile)

    response_types.each do |r_klass|
      t_name = Survey.find(r_klass).table_name
      inconsistent = SurveyResponse.joins(<<-SQL
        INNER JOIN #{t_name} AS r
        ON  survey_responses.response_type = '#{r_klass.to_s}'
        AND survey_responses.response_id = r.id
        WHERE r.election_year_id <> survey_responses.election_id
        OR    r.county_id        <> survey_responses.county_id
      SQL
      ).count

      matching = SurveyResponse.joins(<<-SQL
        INNER JOIN #{t_name} AS r
        ON  survey_responses.response_type = '#{r_klass.to_s}'
        AND survey_responses.response_id = r.id
        WHERE r.election_year_id = survey_responses.election_id
        OR    r.county_id        = survey_responses.county_id
      SQL
      ).count

      srs = SurveyResponse.where(response_type: r_klass.to_s).count

      rs = r_klass.count

      status = matching == srs && srs == rs && inconsistent == 0

      puts "status: #{status}, #{r_klass}: #{rs}, SRs: #{srs}, Matching: #{matching}, Inconsistent: #{inconsistent}"
    end
  end
end