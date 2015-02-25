module Responseable
  extend ActiveSupport::Concern
  include MultiStepModel

  module ClassMethods
    def survey
      @survey ||= Survey.find_by(response_type: self)
    end

    def questions
      @questions ||= survey.questions
    end
  end

  def self.included(klass)
    klass.extend Responseable::ClassMethods

    klass.has_one :survey_response, as: :response, dependent: :destroy
    klass.accepts_nested_attributes_for :survey_response
    klass.has_one :election, through: :survey_response, foreign_key: 'election_year_id', class_name: "ElectionYear"
  end
end