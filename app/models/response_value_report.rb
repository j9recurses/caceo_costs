class ResponseValueReport
  def self.value_view_query
    <<-SQL
      SELECT
        rv.integer_value,
        rv.decimal_value,
        rv.string_value,
        rv.text_value,
        rv.boolean_value,
        rv.na_value,
        rv.question_id,
        q.description,
        q.field,
        q.data_type,
        q.na_able,
        srv.*
      FROM response_values rv
      INNER JOIN ( #{SurveyResponseReport.sr_overview_query}
        ) srv
      ON rv.survey_response_id = srv.survey_response_id
      INNER JOIN questions q
      ON rv.question_id = q.id
    SQL
  end

  def self.value_view
    @value_view ||= ResponseValue.find_by_sql( value_view_query )
  end

  # {
  #   survey_id => [ {
  #       [survey_response_id, county_name, election_name] => {
  #         :stats => [_total_questions, _answered, _total],
  #         field_name => value, field_name => value, ...
  #       }
  #     }, { {} }
  #   ],
  #   survey_id => [ ... ]
  # }
  def self.responses_hash
    if @responses_hash
      @responses_hash
    else
      @responses_hash = {}
      Survey.order(id: :asc).pluck(:id, :title).each do |s_id, s_title|
        @responses_hash[s_id] = {}
      end
      self.value_view.each do |e|
        sr_hash = @responses_hash[e.survey_id][[e.survey_response_id, e.county_name, e.election_name]] ||= {}
        sr_hash[:stats] ||= [e._total_questions, e._answered, e._total]
        sr_hash[e.field] = if e.na_able? && e.na_value
            'N/A'
          else 
            e.send("#{e.data_type}_value")
          end
      end
      @responses_hash
    end
  end

  # structure identical to responses_hash
  def self.tech_responses_hash
    h = {
      'TechVotingMachine'  => {},
      'TechVotingSoftware' => {}
    }
    TechVotingMachine.all.to_a.concat(TechVotingSoftware.all.to_a).each do |t|
      t_hash = h[t.class.to_s][[t.id, t.county.name]] ||= {}
      t_hash[:total] ||= t.total
      t.fields_values.each do |field, value|
        t_hash[field] = value
      end
    end
    h
  end

  # structure identical to question_metadata_hash
  def self.tech_question_metadata_hash
    if @tech_q_hash
      @tech_q_hash
    else
      @tech_q_hash = {}
      [TechVotingSoftware, TechVotingMachine].each do |tech_survey|
        tech_survey.fields.each do |f|
          @tech_q_hash[[tech_survey.to_s, :field]] = tech_survey.descriptions.keys
          @tech_q_hash[[tech_survey.to_s, :description]] = tech_survey.descriptions.values
        end
      end
      @tech_q_hash
    end
  end

  def self.question_metadata_hash
    if @question_metadata
      @question_metadata
    else
      @question_metadata = {}
      Survey.order(id: :asc).pluck(:id, :title).each do |s_id, s_title|
        @question_metadata[[s_id, :field]] = Question.
          where(survey_id: s_id).
          order(id: :asc).
          pluck(:field)
        @question_metadata[[s_id, :description]] = Question.
          where(survey_id: s_id).
          order(id: :asc).
          pluck(:description)
      end
      @question_metadata
    end
  end

  # Diverges from responses_array structure:
  # [ {
  #     [survey_id] => [
  #       [survey_title, current_time, *fields],
  #       ['County', 'Total', *descriptions],
  #       [county_name, total, *values], [county_name, total, *values], [...]
  #   },
  #   { [] => [[...], [...], [...]] }
  # ]
  def self.tech_responses_array
    t_arr = []
    r_hash = tech_responses_hash
    q_hash = tech_question_metadata_hash
    [TechVotingSoftware, TechVotingMachine].each do |tech_survey|
      survey_arr = [ 
        [ tech_survey.title, Time.current.strftime('%F %T%:z'), *tech_survey.fields ],
        ['County', 'Total', *tech_survey.descriptions.values ]
      ]
      tech_survey.all.each do |r|
        survey_arr.push [r.county.name, r.total, *r.values]
      end
      t_arr.push( { tech_survey.id => survey_arr } )
    end
    t_arr
  end

  # [
  #   { [survey_id, survey_title] => [
  #       [county_name, election_name, stats*3, values], [...], [...]] 
  #   },
  #   { [] => [[...], [...], [...]] }
  # ]
  def self.responses_array
    result = []
    r_hash = responses_hash
    q_hash = question_metadata_hash
    survey_ids_titles = Survey.order(id: :asc).pluck(:id, :title)

    # survey page
    survey_ids_titles.each do |s_id, s_title|
      survey_result = []
      sr = r_hash[s_id].keys
      # value row, determined by survey_response_id
      sr.each do |sr_id, c_name, e_name|
        s_row = [c_name, e_name].concat(r_hash[s_id][[sr_id, c_name, e_name]][:stats])
        q_hash[[s_id, :field]].each do |q_field|
          s_row.push r_hash[s_id][[sr_id, c_name, e_name]][q_field]
        end
        survey_result.push s_row
      end
      result.push( { [s_id, s_title] => survey_result } )
    end
    result
  end
end