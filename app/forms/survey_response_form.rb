class SurveyResponseForm < Reform::Form
  extend Forwardable

  def initialize(survey_response)
    survey_response.extend Pageable
    super( survey_response )
  end
  def_delegators :model, *Pageable.instance_methods
  property :county_id
  property :election_id
  property :response_type
  property :response_id
  property :response, form: ResponseForm

  def submit
    raise 'No Response' unless response
    sync

    begin
      SurveyResponse.transaction do
        response.model.save!
        model.response = response.model
        model.save!
        ResponseValue.sync_survey_response model
      end
    rescue
      false
    else
      true
    end
  end

  def empty_na
    Question.where( survey_id: response_type, na_able: true ).each do |q|
      val = if q.multi_select?
        response.send q.multi_select_field
      else
        response.send q.field
      end

      if val.blank? && !(val==false)
        response.validate(q.na_field => true)
      end
    end
    self
  end


  def destroy
    SurveyResponse.transaction do
      model.destroy!
    end
  end
end
