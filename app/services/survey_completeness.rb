class SurveyCompleteness
  def initialize(data = nil)
    @data     = data
    @relation = data .is_a?(ActiveRecord::Relation) ? true : false
    @type = case @relation ? data.first : data
    when SurveyResponse then :sr
    when TechVotingSoftware, TechVotingMachine then :tech
    end
  end
  attr_reader :relation, :type

  # Only SurveyResponse: Tech doesn't have overall completeness
  def self.query(query)
    new( SurveyResponse.where(query) ).in_group
  end

  def percent_complete
    if type == :sr && relation
      ResponseValue.where(id: data.value_ids).percent_answered
    elsif type == :sr && !relation
      data.values.percent_answered
    elsif type == :tech && relation
      t = TechSerializer.new(data)
      percentage(t.answered_count, (t.fields.size * data.count) )
    elsif type == :tech && !relation
      t = TechSerializer.new( data.class.where(id: data.id) )
      percentage(t.answered_count, t.fields.size)
    else nil end
  end

  def in_group
    if relation && type == :sr
      elections = data.pluck(:election_id).uniq
      counties  = data.pluck(:county_id).uniq
      surveys   = data.pluck(:response_type).uniq

      tot_questions = if surveys
        Question.where(survey_id: surveys).count
      else
        Question.count
      end
      tot_counties  = counties.blank?  ? 58 : counties.size
      tot_elections = elections.blank? ? Election.count : elections.size

      available = (tot_questions * tot_counties * tot_elections)
      completed = ResponseValue.where(id: data.value_ids ).answered
      percentage(completed, available)
    else nil end
  end

  def overall
    if type == :sr
      available_qs = (Question.count * 58 * Election.count)
      completed = ResponseValue.where(id: data.value_ids ).answered
      percentage(completed, available_qs)
    else nil end
  end

  def percentage(num, den)
    ratio = ( num.to_f / den.to_f ).round(2)
    ratio = ratio.nan? ? 0 : ratio
    (ratio * 100).to_i
  end
end
