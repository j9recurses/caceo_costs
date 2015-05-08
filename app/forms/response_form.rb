module ResponseAttributable
  include Virtus.model

  def self.included(klass) do |klass|
    survey = Survey.find klass
    survey.questions.select(:field, :data_type).each do |q|
      attribute q.field, q.data_type.titleize.constantize
    end
  end
end

class ResponseForm
  include ActiveModel::Model
  # include Virtus.model
  # include ResponseAttributable

  # attribute :county_id, Integer
  # attribute :election_id, Integer
  # attribute :survey_id, Integer
  # attribute :response_id, 

  def initialize(survey_response, response = nil)
    @survey_response = survey_response
    @response        = response
    if @survey_response.response
      @response = @survey_response.response
    elsif @response
      @response.survey_response = @survey_response
      @survey_response.response = @response
    else
      raise 'Error initializing -- no response model'
    end
    @pages = FormPages.new( @survey_response.survey )
  end
  attr_accessor :survey_response, :response, :pages
  def_delegators :@survey_response, :questions, :survey, :valid?
  # def_delegators :@pages, :total_steps, :current_step, :current_step=, 
    # :step_forward, :step_back, :first_step?, :last_step?

  def enter(param_hash)
    @response.assign_attributes( param_hash )
  end

  def submit(param_hash = nil)
    enter(param_hash) if param_hash
    @survey_response.save!
  end

private
  # def persist!
  #   @survey_response = SurveyResponse.where(county_id: county_id, election_id: election_id, survey_id: survey_id).first_or_create!
  #   @survey_response.question
  # end
end