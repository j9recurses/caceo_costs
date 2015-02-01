namespace :caceo do
  desc 'delete all old surveys, leaving only the most recent'
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

    all_status GeneralSurvey::DIRECT_COST_SURVEYS.inject(true) do |memo, klass|
      memo && delete_with_logs(klass)
    end

    if all_status
      logger.info 'DELETE DUPS ALL STATUS: COMPLETED SUCCESSFULLY'
    else
      logger.info 'ERROR IN DELETE DUPS'
    end
  end
end