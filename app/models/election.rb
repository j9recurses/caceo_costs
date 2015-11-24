class Election < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  # has_many :survey_responses, dependent: :destroy, inverse_of: :election
  default_scope { order(election_dt: :desc) }

  YEAR_ORDER = {
    '2004 Presidential Primary Election'      => 0,
    '2004 Presidential General Election'      => 1,
    '2005 Statewide Special Election'         => 2,
    '2006 Gubernatorial Primary Election'     => 3,
    '2006 General Election'                   => 4,
    '2008 Presidential Primary Election'      => 5,
    '2008 Statewide Direct Primary Election'  => 6,
    '2008 Presidential General Election'      => 7,
    '2009 Statewide Special Election'         => 8,
    '2010 Statewide Direct Primary Election'  => 9,
    '2010 General Election'                   => 10,
    '2012 Presidential Primary Election'      => 11,
    '2012 Presidential General Election'      => 12,
    '2014 Statewide Direct Primary Election'  => 13,
    '2014 General Election'                   => 14
  }


  def index
    YEAR_ORDER[name]
  end

  ####### LEGACY -- will delete shortly

  # def direct_cost_table_names
  #   GeneralSurvey::DIRECT_COST_SURVEYS.map { |t| t.to_s.underscore.pluralize }
  # end

  # def direct_cost_questions
  #   @total_direct_cost_questions ||= Question
  #     .where( table_name: direct_cost_table_names )
  #     .where.not('label LIKE "%Percent%" AND table_name != "salbals"')
  #     .where(question_type: nil)
  # end

  # memo an array of open surveys for this election; else return empty array
  # def direct_cost_surveys_for( user )
  #   @direct_cost_surveys ||= GeneralSurvey::DIRECT_COST_SURVEYS.map { |klass|
  #     klass.where( election_year_id: id, county_id: user.county_id ).last
  #   }.compact
  # end

  # def surveys_open?( user )
  #   !direct_cost_surveys_for( user ).blank?
  # end

  # return nil if there are no open surveys
  # def total_direct_cost_for(user)
  #   @total_direct_cost ||= direct_cost_surveys_for( user ).inject(0) do |mem, surv| 
  #     mem + GeneralSurvey.new(surv).total
  #   end
  # end

  # def direct_cost_answers_count( user )
  #   @total_direct_cost_answers ||= direct_cost_surveys_for( user ).inject(0) { |mem, surv|
  #     mem + GeneralSurvey.new( surv ).count_answers
  #   }
  # end

  # def percent_answered_direct_cost( user )
  #   @percent_answered_direct_cost ||= if direct_cost_answers_count( user )
  #     ((Float(direct_cost_answers_count( user )) / Float(direct_cost_questions.count)) * 100).to_i
  #   else
  #     0
  #   end
  # end
end
