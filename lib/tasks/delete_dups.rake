namespace :caceo do
  desc 'delete all old surveys, leaving only the most recent'
  desc "Task description"
  task delete_sr_dups: :environment do
  
    query = <<-SQL
    DELETE survey_responses.*
    FROM survey_responses
    INNER JOIN
    (
      SELECT MAX(id) id, county_id, election_id, response_type 
      FROM survey_responses 
      GROUP BY county_id, election_id, response_type
    ) d 
    ON d.county_id  = survey_responses.county_id AND 
    d.election_id   = survey_responses.election_id AND 
    d.response_type = survey_responses.response_type AND 
    d.id <> survey_responses.id
    SQL

    ActiveRecord::Base.connection.execute(query)
  end

  task delete_dups: :environment do
    def delete_with_logs(klass)
      s = SurveySql.new(klass)
      logger = Rails.logger
      before = s.cat_status
      if s.delete_dups
        logger.info "#{klass.to_s} DELETE DUPS SUCCESS"
      else
        logger.info "#{klass.to_s} DELETE DUPS FAILURE"
      end
      after = s.cat_status
      logger.info "BEFORE -- \n#{before}"
      logger.info "AFTER -- \n#{after}"
    end

    all_status = GeneralSurvey::DIRECT_COST_SURVEYS.all? do |klass|
      delete_with_logs(klass)
    end

    if all_status
      Rails.logger.info 'DELETE DUPS ALL STATUS: COMPLETED SUCCESSFULLY'
    else
      Rails.logger.info 'ERROR IN DELETE DUPS'
    end
  end
end