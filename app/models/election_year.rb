class ElectionYear < ActiveRecord::Base
  validates :year, :presence => true, :uniqueness => true
  has_many :survey_responses, dependent: :destroy
  #has_many :postages, :through => :year_elements, :source => :element, :source_type => 'postages' , dependent: :destroy
  default_scope { order(election_dt: :desc) }

  def direct_cost_table_names
    GeneralSurvey::DIRECT_COST_SURVEYS.map { |t| t.to_s.underscore.pluralize }
  end

  def direct_cost_questions
    @total_direct_cost_questions ||= Question
      .where( table_name: direct_cost_table_names )
      .where.not('label LIKE "%Percent%" AND table_name != "salbals"')
      .where(question_type: nil)
  end

  # memo an array of open surveys for this election; else return empty array
  def direct_cost_surveys_for( user )
    @direct_cost_surveys ||= GeneralSurvey::DIRECT_COST_SURVEYS.map { |klass|
      klass.where( election_year_id: id, county_id: user.county_id ).last
    }.compact
  end

  def surveys_open?( user )
    !direct_cost_surveys_for( user ).blank?
  end

  # return nil if there are no open surveys
  def total_direct_cost_for(user)
    @total_direct_cost ||= direct_cost_surveys_for( user ).inject(0) do |mem, surv| 
      mem + GeneralSurvey.new(surv).total
    end
  end

  def direct_cost_answers_count( user )
    @total_direct_cost_answers ||= direct_cost_surveys_for( user ).inject(0) { |mem, surv|
      mem + GeneralSurvey.new( surv ).count_answers
    }
  end

  def percent_answered_direct_cost( user )
    @percent_answered_direct_cost ||= if direct_cost_answers_count( user )
      ((Float(direct_cost_answers_count( user )) / Float(direct_cost_questions.count)) * 100).to_i
    else
      0
    end
  end
end
