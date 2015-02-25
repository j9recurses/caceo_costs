class ResponsePersistor
  def initialize(response)
    @response = response
  end
  attr_accessor :response

  def save
    if response.persisted?
      response.save
    else
      response.build_survey_response( survey_response_hash )
      response.save
    end
  end

  def survey_response_hash
    @survey_response_hash ||= {
      response: response, 
      county_id: response.county_id, 
      survey: Survey.find_by( response_type: response.class ),
      election_id: election_foreign_key
    }
  end

  def election_foreign_key
    @election_foreign_key ||= if response.is_a? ElectionProfile
      ElectionYear.find_by( year: ElectionYearProfile.find( response.election_year_profile_id ).year ).id
    else
      response.election_year_id
    end
  end

  def destroy
    response.destroy
  end
end
