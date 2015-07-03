# include Forwardable

class SurveyResponseForm < Reform::Form
  include Composition

  property :county_id, on: :survey_response
  property :election_id, on: :survey_response
  property :response_type, on: :survey_response
  property :response_id, on: :survey_response

  # property(:pages, virtual: true)
   # do
  property :current_step, on: :pages
  # end

  def initialize(survey_response)
    super( 
      survey_response: survey_response, 
      pages: (FormPages.new( survey_response.survey )) )
  end

  def self.survey(survey)
    include(ResponseForm.build(survey))
  end

  # def pages
  #   @pages ||= FormPages.new( @model.survey )
  # end
  # def_delegators :pages, :current_step=, :current_step  # for virtual attribute in controller

  def submit
    raise 'No Response' unless response
    sync
    response.model.county_id        = model.county_id
    response.model.election_year_id = model.election_id
    if SurveyResponse.transaction do
      response.save!
      model.response = response.model
      model.save!
      ResponseValue.sync_survey_response model
    end then true else false end
  end

  def empty_na
    na_qs = Question.where(
      survey_id: response.model.class, na_able: true).pluck(:field, :na_field)
    na_qs.each do |q|
      if response.send(q[0]) == nil
        response.send("#{q[1]}=", true)
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
